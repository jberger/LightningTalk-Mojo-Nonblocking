package ExampleApp::Blocking;

use Mojo::Base 'Mojolicious::Controller';

sub name {
  my ($c, $name) = @_;
  my $doc = $c->name_db->find_one({ name => $name }) || { name => $name };

  my $visits = push @{ $doc->{seen} }, $c->time;

  $c->name_db->save($doc);

  $c->render( text => "Hello $name, $visits visit(s)\n" );
};

1;

