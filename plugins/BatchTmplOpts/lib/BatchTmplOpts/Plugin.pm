package BatchTmplOpts::Plugin;

use strict;

#sub DISABLED ()  { 0 }
#sub ONDEMAND ()  { 1 }
#sub MANUALLY ()  { 2 }
#sub DYNAMIC ()   { 3 }
#sub ASYNC ()     { 4 }
#sub SCHEDULED () { 5 }

use MT::PublishOption;

sub itemset_handler {
    my ($app,$type) = @_;
    $app->validate_magic or return;
    require MT::Template;
    my @tmpls = $app->param('id');
    for my $tmpl_id (@tmpls) {
        my $tmpl = MT::Template->load($tmpl_id) or next;
	$tmpl->build_type($type);
	$tmpl->save();
    }
    $app->add_return_arg( pub_changed => 1 );
    $app->call_return;
}

sub itemset_vpq { return itemset_handler(@_, MT::PublishOption::ASYNC()); }
sub itemset_stc { return itemset_handler(@_, MT::PublishOption::ONDEMAND()); }
sub itemset_dyn { return itemset_handler(@_, MT::PublishOption::DYNAMIC()); }
sub itemset_dis { return itemset_handler(@_, MT::PublishOption::DISABLED()); }
sub itemset_man { return itemset_handler(@_, MT::PublishOption::MANUALLY()); }

1;
