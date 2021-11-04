# Native Type: Machine Image (AMI)

package wiz

default result = "pass"

result = "fail" {
	not input.ImageOwnerAlias = "amazon"
	not input.ImageOwnerAlias = "aws-marketplace"
    input.Public = true
}


