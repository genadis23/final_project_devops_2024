from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = {
    1: {'task_name': 'milk'},
    2: {'task_name': 'door'},
    3: {'task_name': 'light'},
    4: {'task_name': 'tal is the best'}
}


@app.route('/task', methods=['GET'])
def get_tasks():
    return jsonify(tasks)


@app.route('/task/<int:task_id>', methods=['GET'])
def get_task(task_id):
    task = tasks.get(task_id)
    if task:
        return jsonify(task)
    return jsonify({'error': 'Task not found'}), 404


@app.route('/task/<int:task_id>', methods=['PUT'])
def update_task(task_id):
    data_json = request.json
    if task_id in tasks:
        tasks[task_id] = data_json
        return jsonify({'message': 'Task updated'})
    return jsonify({'error': 'Task not found'}), 404


@app.route('/task/add', methods=['POST'])
def add_task():
    # Use request.json to directly access the parsed JSON data
    data_json = request.json
    new_id = max(tasks.keys()) + 1 if tasks else 1  # Handle if tasks is empty
    tasks[new_id] = {'task_name': data_json.get('task_name')}  # Assuming you want to store it this way
    return jsonify({'message': 'Task added', 'id': new_id})


@app.route('/task/delete/<int:task_id>', methods=['DELETE'])
def delete_task(task_id):
    if task_id in tasks:
        del tasks[task_id]
        return jsonify({'message': 'Task deleted'})
    return jsonify({'error': 'Task not found'}), 404


if __name__ == '__main__':
    app.run(debug=True)
