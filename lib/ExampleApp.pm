package ExampleApp;
use Mojo::Base 'Mojolicious';

use Mango;
use Mango::BSON 'bson_time';

sub startup {
  my $app = shift;
  $app->plugin( 'ActionArg' => keys => ['name'] );

  $app->helper( mango   => sub { 
    state $mango = Mango->new('mongodb://localhost/example')
  } );
  $app->helper( name_db => sub { shift->mango->db->collection('names') } );
  $app->helper( time    => sub { bson_time } );

  my $r = $app->routes;

  # simple route to demonstrate plugin
  $r->any( '/argtest/:name' => sub {
    my ($c, $name) = @_;
    $c->render( text => "You entered name: $name\n" );
  });

  $r->any('/blocking/:name')->to('blocking#name');
  $r->any('/nonblocking/:name')->to('non_blocking#name');
  $r->any('/steps/:name')->to('steps#name');
}

1;

