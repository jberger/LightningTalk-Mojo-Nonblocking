package ExampleApp::Steps;
use Mojo::Base 'Mojolicious::Controller';

sub name {
  my ($c, $name) = @_;
  $c->render_later;

  my $delay = Mojo::IOLoop->delay;
  $delay->steps(
    sub {
      my $delay = shift;
      $c->name_db->find_one({ name => $name }, $delay->begin);
    },
    sub {
      my ($delay, $err, $doc) = @_;
      $doc ||= { name => $name };
      my $visits = push @{ $doc->{seen} }, $c->time;
      my $end = $delay->begin(0);
      $c->name_db->save($doc, sub{ $end->($visits) });
    },
    sub {
      my ($delay, $visits) = @_;
      $c->render( text => "Hello $name, $visits visit(s)\n" );
    },
  );
}

1;

