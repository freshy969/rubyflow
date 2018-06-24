sed -i '' -e "s/GddevRailsBoilerplate/$1/g" ./config/application.rb
sed -i '' -e "s/GddevRailsBoilerplate/$1/g" ./app/views/layouts/application.html.haml
rm -rf .git/
