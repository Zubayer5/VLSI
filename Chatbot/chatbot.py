from flask import Flask, render_template, request
app = Flask(__name__)

# Maintain conversation history
conversation_history = []


# Function to process user input and provide a response
def process_input(user_input):
    global conversation_history


    if len(conversation_history)==0 and user_input=="I want to buy a ticket" :
        response = "Do you want a buy a airplane, bus or ship ticket?"
        conversation_history.append(user_input)
    elif len(conversation_history)==0:
           response = "I am sorry I don't know what to do. Please try again."        

    if len(conversation_history) == 1 and user_input=="bus" or len(conversation_history) == 1 and user_input=="airplane" :
        response = "From where to where?"
        conversation_history.append(user_input)
    elif len(conversation_history) == 1  :
          response = "Please select bus or airplane."

    if len(conversation_history) == 2 and user_input=="dhaka to chittagong":
        response = "Which sit would you like?"
        conversation_history.append(user_input)
    elif len(conversation_history) == 2  :
            response = "Please select starting point and destination"      
    if len(conversation_history) == 3 and user_input=="window seat" and conversation_history[1]=="bus" :
           response = "That will be $10"
           conversation_history=[]
                
    elif len(conversation_history) == 3 and user_input=="window seat" and conversation_history[1]=="airplane" :
              response = "That will be $12"
              conversation_history=[]
             
    return response


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/get_response", methods=["POST"])
def get_response():
    user_input = request.form["user_input"]
    response = process_input(user_input)
    return response


if __name__ == "__main__":
    app.run(debug=True)