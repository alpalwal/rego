# Native Type: ELB V2 Application Load Balancer

package wiz

now_ns := time.now_ns()
one_wk_ns := time.parse_duration_ns("168h") # 7d in hours

default result = "pass"
default iam_cert_expiring_soon = false
default acm_cert_expiring_soon = false

## Two types of certs ALBs can have. Check both
iam_cert_expiring_soon {
	now_ns - time.parse_rfc3339_ns(input.loadBalancerListenerIamCertificates[i].ServerCertificateMetadata.Expiration) > one_wk_ns
}

acm_cert_expiring_soon {
	now_ns - time.parse_rfc3339_ns(input.loadBalancerListenerAcmCertificates[i].NotAfter) > one_wk_ns
}

result = "fail" {iam_cert_expiring_soon} {acm_cert_expiring_soon}
