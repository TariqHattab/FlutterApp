from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()
"""
  List<Task> tasks;
  String notes;
  DateTime timeToComplete;
  bool completed;
  String requests;
  DateTime deadline;
  List<DateTime> reminders;
  String taskId;
  String title;
"""
class Register(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username= db.Column(db.String(250), nullable=False)
    lastName = db.Column(db.String(250), nullable = False)
    firstName = db.Column(db.String(250), nullable=False) 
    email = db.Column(db.String(250), nullable=False)
    password = db.Column(db.String(250), nullable=False)
    registeredAt = db.Column(db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False)
    
    def __init__(self, username, firstName, lastName, email, password):
        self.username= username
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        
class RegisterSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    username = fields.String(required=True)
    firstName = fields.String(required=True)
    lastName = fields.String(required=True)
    email = fields.String(required=True)
    password = fields.String(required=True)    
    registeredAt = fields.DateTime()

class Task(db.Model):
    __tablename__ = 'tasks'
    id = db.Column(db.Integer, primary_key=True)
    task = db.Column(db.String(250), nullable=False)
    creation_date = db.Column(db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False)
    notes = db.Column(db.String(250), nullable=True)
    completed = db.Column(db.Boolean, nullable=False)

    # category_id = db.Column(db.Integer, db.ForeignKey('categories.id', ondelete='CASCADE'), nullable=False)
    # category = db.relationship('Category', backref=db.backref('comments', lazy='dynamic' ))

    def __init__(self, task, completed,notes):
        self.task = task
        self.completed = completed
        self.notes = notes
        
class TaskSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    task = fields.String(required=True)
    notes = fields.String()
    creation_date = fields.DateTime()
    completed = fields.Bool(required=True)

class Comment(db.Model):
    __tablename__ = 'comments'
    id = db.Column(db.Integer, primary_key=True)
    comment = db.Column(db.String(250), nullable=False)
    creation_date = db.Column(db.TIMESTAMP, server_default=db.func.current_timestamp(), nullable=False)
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id', ondelete='CASCADE'), nullable=False)
    category = db.relationship('Category', backref=db.backref('comments', lazy='dynamic' ))

    def __init__(self, comment, category_id):
        self.comment = comment
        self.category_id = category_id

class CommentSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    category_id = fields.Integer(required=True)
    comment = fields.String(required=True, validate=validate.Length(1))
    creation_date = fields.DateTime()

class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150), unique=True, nullable=False)

    def __init__(self, name):
        self.name = name


class CategorySchema(ma.Schema):
    id = fields.Integer()
    name = fields.String(required=True)


