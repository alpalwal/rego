package wiz
default result = "pass"

# Fail if it doesn't have a deny and doesn't have the key/value
result = "fail" {
	has_deny == false
	has_tag == false
}

# Checking if there is a deny for the default action. 
has_deny = a {
	a = input.properties.networkAcls.defaultAction == "Deny"
}

# Checking if there is a key of ms-resource-usage and the value of azure-public-terraform. Will return as false if either isn't true
# Using this logic to look for key/value becasue "-" in tags will throw an error in rego if looking like this:
# not input.tags.ms-resource-usage == "azure-public-terraform"
has_tag = b {
	b = "azure-public-terraform" == input.tags["ms-resource-usage"]
}

currentConfiguration = "The default firewall action is not set to Allow."
expectedConfiguration = "The default firewall action should be set to Deny to ensure only requuired IPs are allowed access."

# {
#   "etag": "W/\"175c3b3e-3c56-47a4-8724-918d045141bb\"",
#   "id": "/subscriptions/fee3535b-9616-486f-a476-6a500a08a02b/resourceGroups/creds-internal-storage/providers/Microsoft.Network/networkSecurityGroups/RedHat7.4-enterprise-creds-nsg",
#   "location": "westeurope",
#   "name": "RedHat7.4-enterprise-creds-nsg",
#   "properties": {
#     "networkAcls": {
#     	"defaultAction": "Deny"
# 	  }
#   },
#   "tags": {
#     "ms-resource-usage": "azure-public-terraform",
#     "azureTag": "azusre-public-terraform"
#           },
#   "type": "Microsoft.Network/networkSecurityGroups"
# }