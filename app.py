import sqlite3
import os
from flask import Flask, jsonify, g
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATABASE = os.path.join(BASE_DIR, "politicians.db")
DUMP_PATH = os.path.join(BASE_DIR, "politicians_dump.sql")

def get_db():
    if "db" not in g:
        g.db = sqlite3.connect(DATABASE)
        g.db.row_factory = sqlite3.Row
    return g.db

@app.teardown_appcontext
def close_db(exception):
    db = g.pop("db", None)
    if db is not None:
        db.close()

def init_db_from_dump():
    if os.path.exists(DATABASE):
        return
    if not os.path.exists(DUMP_PATH):
        raise FileNotFoundError("Nedostaje politicians_dump.sql.")
    conn = sqlite3.connect(DATABASE)
    with open(DUMP_PATH, "r", encoding="utf-8") as f:
        conn.executescript(f.read())
    conn.commit()
    conn.close()
    print(f"Baza inicijalizirana: {DATABASE}")

@app.route("/api/politicians", methods=["GET"])
def get_politicians():
    db = get_db()
    politicians = db.execute("SELECT * FROM politicians ORDER BY id").fetchall()
    terms = db.execute("SELECT * FROM terms_in_office ORDER BY politician_id, start_year").fetchall()
    actions = db.execute("SELECT * FROM legislative_actions ORDER BY politician_id, year").fetchall()
    committees = db.execute("SELECT * FROM committee_memberships ORDER BY politician_id, start_year").fetchall()

    terms_by_politician = {}
    for t in terms:
        terms_by_politician.setdefault(t["politician_id"], []).append({
            "role": t["role"],
            "start_year": t["start_year"],
            "end_year": t["end_year"],
        })

    actions_by_politician = {}
    for a in actions:
        actions_by_politician.setdefault(a["politician_id"], []).append({
            "title": a["title"],
            "action_type": a["action_type"],
            "year": a["year"],
            "status": a["status"]
        })

    committees_by_politician = {}
    for c in committees:
        committees_by_politician.setdefault(c["politician_id"], []).append({
            "committee_name": c["committee_name"],
            "role": c["role"],
            "start_year": c["start_year"],
            "end_year": c["end_year"]
        })

    result = []
    for p in politicians:
        result.append({
            "id": p["id"],
            "first_name": p["first_name"],
            "last_name": p["last_name"],
            "birth_year": p["birth_year"],
            "country": p["country"],
            "current_office": p["current_office"],
            "is_active": p["is_active"],
            "education_level": p["education_level"],
            "official_website": p["official_website"],
            "party_affiliation": {
                "party_name": p["party_name"],
                "ideology": p["ideology"],
            },
            "terms_in_office": terms_by_politician.get(p["id"], []),
            "legislative_actions": actions_by_politician.get(p["id"], []),
            "committee_memberships": committees_by_politician.get(p["id"], []),
        })

    return jsonify(result)

if __name__ == "__main__":
    init_db_from_dump()
    app.run(debug=True, port=5000)