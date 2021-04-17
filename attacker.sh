fecha=""
password=""
email=""
year=00
rnd_numb=0
new_password=""
old_password="sample"
new_email=""
old_email="sample"


rnd_number(){
	rnd_numb=$(awk -v min=$1 -v max=$2 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
}

get_random_password(){
	random_number=$(
	awk -v min=1 -v max=999998 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
	command=$(echo "$random_number!d")
	#echo $command
	password=$(sed $command 100passwords.txt)
}

main(){
	get_random_password
	rnd_number 1 21
	year=$(printf "%02d" $rnd_numb)
	rnd_number 1 9999
	number=$(printf "%06d" $rnd_numb)
	email="zS$year$number@estudiantes.uv.mx"

	#echo $password
	#echo $email
        send_request
}

send_request(){
	new_password=$(echo $password)
	new_email=$(echo $email)

	hide=$(echo "-s -o /dev/null")
	#hide=""

	if [ $new_email != $old_email ] && [ $new_password != $old_password ];
	then
	        echo "sending $email $password"

		parameter1=$(echo "_u884422805367339903='=$email'")
	        parameter2=$(echo "_u476352899118996823='$password'")
		curl $hide --location --request POST 'https://estudiant-uv-mx.weebly.com/ajax/apps/formSubmitAjax.php?form_version=2&ucfid=813446533666397904' \
		--header 'Cookie:  is_mobile=0; language=es; _snow_ses.71e0=*; _snow_id.71e0=feddda15-5ab7-4fa8-a057-df184b82c393.1618619607.1.1618619965.1618619607.5795f969-4de2-4b94-903b-24813b3b97f8; sto-id-editor=BFALBOAK; _ga=GA1.2.681068463.1618620177; _gid=GA1.2.707912317.1618620177; language=es' \
		--form $parameter1 \
		--form $parameter2
	fi
	sleep 1
	old_email=$(echo $new_password)
	old_password=$(echo $new_email)
}

while :
do
  main
done
