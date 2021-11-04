# Native Type: IAM User

package wiz

default access_key_1_rotated_lately = false
default access_key_2_rotated_lately = false
default password_rotated_lately = false
default old_user = false
default has_something_active = false

default result = "pass"

now_ns := time.now_ns()
ninty_days_ns := time.parse_duration_ns("2160h") # 90d in hours

access_key_1_rotated_lately = true {
    input.userCredentials.AccessKey1Active == "true"
	now_ns - time.parse_rfc3339_ns(input.userCredentials.AccessKey1LastRotated) < ninty_days_ns
}

access_key_2_rotated_lately = true {
    input.userCredentials.AccessKey2Active == "true"
    now_ns - time.parse_rfc3339_ns(input.userCredentials.AccessKey2LastRotated) < ninty_days_ns
}
password_rotated_lately = true {
    input.userCredentials.PasswordEnabled == "true"
    now_ns - time.parse_rfc3339_ns(input.userCredentials.PasswordLastChanged) < ninty_days_ns
}

old_user = true {
	now_ns - time.parse_rfc3339_ns(input.CreateDate) > ninty_days_ns
}    

has_something_active = true {
	input.userCredentials.PasswordEnabled == "true"}
    {input.userCredentials.AccessKey2Active == "true"}
    {input.userCredentials.AccessKey1Active == "true"
}


result = "fail" {
	not access_key_1_rotated_lately
    old_user 
    has_something_active}
    {not access_key_2_rotated_lately
    old_user
    has_something_active}
    {not password_rotated_lately
    old_user
    has_something_active
}
