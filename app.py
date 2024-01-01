from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename
import os
import cv2
import mysql.connector

app = Flask(__name__)

# Configuration for file uploads
app.config['UPLOAD_FOLDER'] = 'static/assets/uploads'
app.config['COVER_PHOTOS_FOLDER'] = 'static/assets/uploads'
app.config['ALLOWED_EXTENSIONS'] = {'mp4', 'jpg', 'jpeg', 'png'}

# Function to check if the file extension is allowed
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

# Function to extract a frame from a video and save it as an image
def extract_frame(video_path, output_image_path, frame_time):
    cap = cv2.VideoCapture(video_path)
    cap.set(cv2.CAP_PROP_POS_MSEC, frame_time * 1000)
    ret, frame = cap.read()
    if ret:
        cv2.imwrite(output_image_path, frame)
        cap.release()
        return True
    else:
        cap.release()
        return False

# MySQL database configuration
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="myVideo"
)

@app.route('/')
def index():
    cur = mydb.cursor(dictionary=True)
    cur.execute("SELECT * FROM video")
    videos = cur.fetchall()
    cur.close()
    return render_template('index.html', videos=videos)

# static files 
@app.route('/static/<path:filename>')
def serve_static(filename):
    return send_from_directory(app.static_folder, filename)

@app.route('/vid_upload', methods=['POST'])
def upload():
    if request.method == 'POST':
        title = request.form['title']
        desc = request.form['desc']

        # File handling for video
        video = request.files['video']
        if video and allowed_file(video.filename):
            video_filename = secure_filename(video.filename)
            video_path = os.path.join(app.config['UPLOAD_FOLDER'], video_filename)
            video.save(video_path)

            # Extract a frame from the uploaded video as a cover photo
            cover_photo_filename = f"cover_{secure_filename(title)}_odiedo.jpg"
            cover_photo_path = os.path.join(app.config['COVER_PHOTOS_FOLDER'], cover_photo_filename)
            if extract_frame(video_path, cover_photo_path, frame_time=5):
                # Save video and cover photo details to db
                mycursor = mydb.cursor()
                try:
                    sql = "INSERT INTO video (`title`, `desc`, `video`, `v_image`) VALUES (%s, %s, %s, %s)"
                    val = (title, desc, video_filename, cover_photo_filename)
                    mycursor.execute(sql, val)
                    mydb.commit()
                    return render_template('index.html', title=title, desc=desc, video=video_path, v_image=cover_photo_path) 
                except mysql.connector.Error as err:
                    print(f"Error: {err}")
                    return "An error occurred while saving data to the database."
                finally:
                    mycursor.close()

            else:
                return "Failed to extract cover photo from the video."

        else:
            return "Invalid video file format!"

    else:
        return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
