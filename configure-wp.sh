retries=0
while :
do
  if wp core install --url="localhost" --title="test blog" --admin_user="admin" --admin_password="parol" --admin_email="admin@email.com"
  then
    break
  else
    retries=$((retries+1))
    echo "Couldn't connect to DB. Try - ${retries}. Sleeping 10 seconds and will retry ..."
    sleep 10
  fi
  if [ "${retries}" -eq "5" ]
  then
    echo "Something went wrong. Exiting."
    exit 1
  fi
done
wp theme install liana --activate
if [ "$(wp post list|wc -l)" -lt "10" ]
then
  curl http://loripsum.net/api/5 | wp post generate --post_content --count=10
else
  echo "Already got enough posts"
fi
wp plugin uninstall akismet
wp plugin uninstall hello
wp plugin install /opt/thank-after-post.zip
wp plugin activate thank-after-post
wp plugin list
