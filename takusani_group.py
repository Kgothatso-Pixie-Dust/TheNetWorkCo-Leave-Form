from flask import Flask, request, render_template, session, redirect 
import datetime
import mysql.connector
import bcrypt

app = Flask(__name__) 

db = mysql.connector.connect(
    host="localhost",
    user="root",  # Change if needed
    password="",  
    database="companyDB"
)
@app.route('/login', methods=['GET', 'POST'])  
def login():  
    if request.method == 'POST':  
        username = request.form['username']  
        email = request.form['email']  
        password = request.form['password']  
        conn = db  
        cursor = conn.cursor()  

        # Fetch user info  
        cursor.execute("SELECT password FROM users WHERE username = %s AND email = %s", (username, email))  
        user = cursor.fetchone()  
        
        if user and bcrypt.checkpw(password.encode('utf-8'), user[0].encode('utf-8')):  
            session['username'] = username  
            return redirect('/')  # Redirect to leave request form  
        else:  
            return "Invalid credentials. Please try again."  

    return render_template('login.html')  

@app.route('/')  
def home():  
    return render_template('index.html')  

@app.route('/save', methods=['POST'])  
def save():  
    leave_day = 30
    cursor = db.cursor()

    full_name = request.form.get("name")
    intern_pos = request.form.get("intership-position")
    comp_position = request.form.get("company-name")
    super_name = request.form.get("supervisor's-name")
    start_date = request.form.get("start-date")
    end_date = request.form.get("end-date")
    other_reason = request.form.get("other")
    work_hand_plan = request.form.get("handover-plan")

    academic_commit = "academic-commitment" in request.form
    personal_reas = "personal-reason" in request.form
    medical_reas = "medical-reason" in request.form
    converted_start_date = datetime.strptime(start_date, '%Y-%m-%d')
    converted_end_date = datetime.strptime(start_date, '%Y-%m-%d')
    days_absent = (converted_end_date - converted_start_date).days + 1
    calculated_leave_days = leave_day - (converted_end_date - converted_start_date).days + 1

    sql = """INSERT INTO LEAVE_REQUEST 
        (FULL_NAME, INTERN_POS, COMP_POSITION, SUPER_NAME, START_DATE, END_DATE, DAYS_ABSENT, REMAIN_LEAVE_DAYS, ACADEM_COMMIT, PERSONAL_REAS, MEDICAL_REAS, OTHER, WORK_HAND_PLAN) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
   
    
    values = (full_name, intern_pos, comp_position, super_name, start_date, end_date, days_absent, calculated_leave_days,
              academic_commit, personal_reas, medical_reas, other_reason, work_hand_plan)
    
    # cursor.execute(sql, values)
    # db.commit()
    # cursor.close()
    try:  
        cursor.execute(sql, values)
        db.commit()  
    except mysql.connector.Error as err:  
        print(f"Error: {err}")  
    finally:  
        cursor.close()  
        db.close() 

    return render_template('login.html')
    
    # name = request.form['name']  
    # intership_position = request.form['intership-position']  
    # company_name = request.form['company-name']  
    # supervisor_name = request.form["supervisor's-name"]  
    # start_date = request.form['start-date']  
    # end_date = request.form['end-date']  
    # academic_commitment = request.form['academic-commitment']  
    # personal_reason = request.form['personal-reason']  
    # medical_reason = request.form['medical-reasonn']  
    # other = request.form['other']  
    # handover_plan = request.form['handover-plan']     
    # converted_start_date = datetime.strptime(start_date, '%Y-%m-%d')
    # converted_end_date = datetime.strptime(start_date, '%Y-%m-%d')
    # calculated_leave_days = leave_day - (converted_end_date - converted_start_date).days + 1
    # cursor = db.cursor()
    # sql = "INSERT INTO applications (name, email, position) VALUES (%s, %s, %s,%s, %s, %s, %s, %s, %s)"
    # values = (name, intership_position, company_name, supervisor_name, start_date, end_date, academic_commitment, personal_reason, medical_reason,other, handover_plan)
    # cursor.execute(sql, values)
    # db.commit()
    # return "Data saved successfully! <a href='/'>Go Back</a>"  

if __name__ == '__main__':  
    app.run(debug=True)  