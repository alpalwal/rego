# Native Type: ELB V2 Application Load Balancer

package wiz

now_ns := time.now_ns()
one_wk_ns := time.parse_duration_ns("168h") # 7d in hours

default result = "pass"

result = "fail" {
	now_ns - time.parse_rfc3339_ns(input.loadBalancerListenerIamCertificates[i].ServerCertificateMetadata.Expiration) > one_wk_ns
}
