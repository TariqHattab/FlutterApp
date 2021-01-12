from flask import request
from flask_restful import Resource
from Model import db, Task, TaskSchema

tasks_schema = TaskSchema(many=True)
task_schema = TaskSchema()

class TaskResource(Resource):
    def get(self):
        tasks = Task.query.all()
        tasks = tasks_schema.dump(tasks).data
        return {'status': 'success', 'data': tasks}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return {'message': 'No input data provided'}, 400
        # Validate and deserialize input
        data, errors = task_schema.load(json_data)
        if errors:
            return {"status": "error", "data": errors}, 422
        # task_id = Task.query.filter_by(id=data['id']).first()
        # if not task_id:
        #     return {'status': 'error', 'message': 'task id not found'}, 4
        notes = json_data['notes'] or 'nothing'
        task = Task(
            task=json_data['task'],
            completed=json_data['completed'],
            notes = notes
        )
        db.session.add(task)
        db.session.commit()

        result = task_schema.dump(task).data

        return { "status": 'success', 'data': result }, 201