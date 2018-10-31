import xml.etree.ElementTree as et

from sys import argv

def traverse(root):

#	print(root.tag)
#	print('***')
#	print(root.attrib)

	for child in root:
		traverse(child)

onto = et.parse(argv[1])
root = onto.getroot()

#traverse(root)

for child in root:

	if child.tag.endswith('ClassAssertion'):
		_class = child[0]
		_territory = child[1]
		if _class.get('IRI') == '#Territory':
			print('territory(\"{}\").'.format(_territory.get('IRI')[1:]))

	elif child.tag.endswith('ObjectPropertyAssertion'):
		prop = child[0]
		_from = child[1]
		_to = child[2]
		if prop.get('IRI') == '#Borders':
			print('border(\"{}\", \"{}\").'.format(_from.get('IRI')[1:],
			_to.get('IRI')[1:]))
			print('border(\"{}\", \"{}\").'.format(_to.get('IRI')[1:],
			_from.get('IRI')[1:]))