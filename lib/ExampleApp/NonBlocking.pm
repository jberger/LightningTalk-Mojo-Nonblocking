package ExampleApp::NonBlocking;
use Mojo::Base 'Mojolicious::Controller';

sub name {
  my ($c, $name) = @_;
  $c->render_later;
  $c->name_db->find_one({ name => $name }, sub {
    my ($delay, $err, $doc) = @_;
    $doc ||= { name => $name };

    my $visits = push @{ $doc->{seen} }, $c->time;

    $c->name_db->save($doc, sub {
      $c->render( text => "Hello $name, $visits visit(s)\n" );
    });

  });
}

1;

