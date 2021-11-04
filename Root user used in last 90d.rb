# Native Type: IAM Root User

package wiz

default access_key_1_used_lately = false
default access_key_2_used_lately = false
default password_used_lately = false

default result = "pass"

now_ns := time.now_ns()
ninty_days_ns := time.parse_duration_ns("2160h") # 90d in hours
lastused_ns := time.parse_rfc3339_ns(input.PasswordLastUsed)

access_key_1_used_lately = true {
    input.userCredentials.AccessKey1Active == "true"
	now_ns - time.parse_rfc3339_ns(input.AccessKey1LastUsedDate) < ninty_days_ns
}

access_key_2_used_lately = true {
    input.userCredentials.AccessKey2Active == "true"
    now_ns - time.parse_rfc3339_ns(input.AccessKey2LastUsedDate) < ninty_days_ns
}
password_used_lately = true {
    now_ns - time.parse_rfc3339_ns(input.PasswordLastUsed) < ninty_days_ns
}

result = "fail" 
	{ access_key_1_used_lately}
	{ access_key_2_used_lately}
	{ password_used_lately }

