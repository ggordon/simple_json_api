tag1 = Tag.create(name: 'Urgent!')
tag2 = Tag.create(name: 'On Hold')

p1 = Project.create(name: 'First Project')
p1.tags << tag1
p2 = Project.create(name: 'Second Project')
p2.tags << tag2
