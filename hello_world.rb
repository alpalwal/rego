# EC2 instances should be EBS Optimized
package wiz
default result = "pass"

result = "fail" {
	input.EbsOptimized == false
}
