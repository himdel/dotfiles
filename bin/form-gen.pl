#!/usr/bin/env perl
use v5.14;

say <<"EOH";
<form class="form-horizontal">
EOH

while (<>) {
	chomp;
	next if /^\s*(#.*)?$/;
	my ($name, $type, $label) = split /\s+/;

	say <<"EOH";
	<div class="form-group">
		<label class="col-xs-2 control-label" for="$name">$label</label>
		<div class="col-xs-3">
			<input class="form-control" name="$name" type="$type" placeholder="$label" ng-model="FOO.$name" />
		</div>
	</div>
EOH
}

say <<"EOH";
	<div class="form-group">
		<div class="col-xs-5 col-xs-offset-2">
			<a class="btn btn-primary" href="" ng-click="StdUpdate()">
				<span ng-hide="FOO.id">Vytvoř</span>
				<span ng-show="FOO.id">Uprav</span>
			</a>
			<a class="btn btn-danger" href="" sa-confirm="StdDelete()" ng-disabled="! FOO.id">Smaž</a>
			<a class="btn" ng-class="{ 'btn-default': ! form.\$dirty, 'btn-warning': form.\$dirty }" href="" ng-click="StdFormOff()">Zpět</a>
		</div>
	</div>
</form>
EOH
