tag1 = Tag.create(guid: 10, name: 'Urgent!')
tag2 = Tag.create(guid: 20, name: 'On Hold')
tag3 = Tag.create(guid: 30, name: 'Favorite')

project1 = Project.create(id: 100,
                          name: 'First Project',
                          description: 'The first project')
project1.tags << tag1
project2 = Project.create(id: 110,
                          name: 'Second Project',
                          description: 'The second project')
project2.tags << tag2

list1 = project1.create_todolist(id: 200, description: 'Groceries')
list1.tags << tag3
todo1 = list1.todos.create(id: 300, action: 'Milk')
todo1.tags << tag1
todo1.tags << tag3

todo2 = list1.todos.create(id: 301, action: 'Bread')
todo2.tags << tag1


list2 = project2.create_todolist(id: 210, description: 'Work')
list2.todos.create(id: 310, action: 'Timesheet')
list2.todos.create(id: 320, action: 'Meeting')
todo3 = list2.todos.create(id: 330, action: 'Present Agenda')
todo3.tags << tag1
