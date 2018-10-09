#!/usr/bin/expect

spawn ssh 192.168.4.5

expect {
"yes/no"  {send "yes\r;exp_continue"}
"password" {send "1\r"}
"#"  {send "touch 1.txt\r"}
"#"  {send "exit\r"}
}
interact
        


    
02d017d0-3ccb-4b64-8e37-791541142819

2cd9e268-fe04-40e4-b272-0d70f7e185fa
