jindu(){
while :
do
    echo -n '#'
    sleep 1
done
} 
cp -r $1 $2 &
jindu
kill $!
