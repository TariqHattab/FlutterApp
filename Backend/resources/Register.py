from flask import request
from flask_restful import Resource
from Model import db, Register, RegisterSchema

users_schema = RegisterSchema(many=True)
user_schema = RegisterSchema()

class RegisterResource(Resource):
    def get(self):
        users = Register.query.all()
        users = users_schema.dump(users).data
        return {'status': 'success', 'data': users}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        # Validate and deserialize input
        data, errors = user_schema.load(json_data)
        if errors:
            return errors, 422
        user = Register.query.filter_by(username=data['username']).first()
        if user:
            return {'message': 'User already exists'}, 400
        user = Register(
            username=json_data['username'],
            firstName=json_data['firstName'],
            lastName=json_data['lastName'],
            password=json_data['password'],
            email=json_data['email']
        )

        db.session.add(user)
        db.session.commit()

        result = user_schema.dump(user).data

        return { "status": 'success', 'data': result }, 201

    def patch(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        # Validate and deserialize input
        data, errors = user_schema.load(json_data)
        
        user = Register.query.filter_by(username=data['username']).first()

        if user:
           
            # return {'message': f'User is {data["password"]}'}, 200    
            if user.password == data["password"]:
                return {'message': f"User found and password correct {user.password}",'status':'true'}, 200
            else: 
                return {'message': 'Password is not correct','status':'falsePassword'}, 200
        else:
            return {'message': 'User not found','status':'falseUser'}, 200    
