#!/bin/bash

FILE="js/app.js"
if [ $# = 1 ]; then
	FILE=$1
fi

if [ -e "$FILE" ]; then
	echo already exists: 1>&2
	ls -l "$FILE" 1>&2
	exit 1
fi

appname=app_$(basename "$FILE" .js)

cat > "$FILE" << EOF
var app = app.module('${appname}', [
]);

app
.service('SVC', function(\$http, \$q) {
	var SVC = this;

	SVC.list = function() {
		return \$q( [] );
	};
});

app
.controller('CTRL', function(\$scope, SVC) {
	\$scope.foo = {};

	\$scope.bar = function(baz) {
		SVC.list()
		.then( _scope_setter(\$scope, 'foo' );
	};
});
EOF

sed -i '/<\/head>/i\\t<script type="text/javascript" src="/'"$FILE"'"></script>' index.html
