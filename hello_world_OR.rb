# Instances should be EBS optimized OR have less than 3 core CPU
#### We use an AND for the logic because if BOTH parameter isn't met, we haven't hit the OR
package wiz
default result = "pass"

result = "fail" {
    input.EbsOptimized == false
    input.CpuOptions.CoreCount < 3
}