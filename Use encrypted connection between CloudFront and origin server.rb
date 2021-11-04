#Native Type: CloudFront Distribution


package wiz

default result = "pass"
default has_origin_config = false
default has_https_something = false


has_origin_config {
	input.Origins.Items[i].S3OriginConfig != null
    }

 has_https_something {
 	input.Origins.Items[i].CustomOriginConfig.OriginProtocolPolicy == "https-only"
 }{
 	input.DefaultCacheBehavior.ViewerProtocolPolicy == "https-only"
 }{
 	input.DefaultCacheBehavior.ViewerProtocolPolicy == "redirect-to-https"
 }
 
 result = "fail" {
 	not has_origin_config
    not has_https_something
 }
 
