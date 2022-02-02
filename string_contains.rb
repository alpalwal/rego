package wiz

default result = "fail"

contact = a{
	a = input.SecurityContacts[i].properties.email
}

# loop through an array and make it positive if we find a colon in the string
hasColon = b{
	b = contains(input.SecurityContacts[i].properties.email, ";")
}

result = "pass" {
	hasColon
}