#!/usr/bin/env perl

use Mojolicious::Lite;

plugin 'PPI', toggle_button => 1;

my $slides = plugin 'SimpleSlides';
$slides->column_width('50')->last_slide(6);

any '/index' => 'index';

app->start;

__DATA__

@@ 1.html.ep

% title 'Fun with Non-blocking Things';

%= tag ul => begin
  %= tag li => q{let's build a logger app}
  %= tag li => q{when you request a page, it logs when you arrived}
  %= tag li => q{let's store logs per username}
  %= tag li => q{let's pretend that find_and_modify doesn't exist}
  %= tag li => q{need to lookup, then append}
% end

@@ 2.html.ep

% title 'A Simple App';

%= columns begin

  %= column begin
    %= tag ul => begin
      %= tag li => 'defined some helpers'
      %= tag li => 'one really evil hook (just for fun)'
      %= tag li => 'define some routes'
    % end
  % end
  %= column begin
    %= ppi 'lib/ExampleApp.pm';
  % end

% end

@@ 3.html.ep

% title 'The Usual (Blocking) Way';

%= columns begin

  %= column begin
    %= tag ul => begin
      %= tag li => 'easy to write'
      %= tag li => 'both db operations block the WHOLE SERVER!!'
    % end
  % end
  %= column begin
    %= ppi 'lib/ExampleApp/Blocking.pm'
  % end

% end

@@ 4.html.ep

% title 'The Non-blocking Way';

%= columns begin

  %= column begin
    %= tag ul => begin
      %= tag li => q{the db operations don't block the server}
      %= tag li => 'arrow code (callback hell)'
    % end
  % end
  %= column begin
    %= ppi 'lib/ExampleApp/NonBlocking.pm'
  % end

% end

@@ 5.html.ep

% title 'The Non-blocking Steps Way';

%= columns begin

  %= column begin
    %= tag ul => begin
      %= tag li => q{the db operations don't block the server}
      %= tag li => 'the code looks longer but ...'
      %= tag li => 'no arrow code (no callback hell)!'
    % end
  % end
  %= column begin
    %= ppi 'lib/ExampleApp/Steps.pm'
  % end

% end

@@ 6.html.ep

% title 'Back to that Evil Hook ...';

%= tag h2 => 'Hacking the action dispatcher'

%= columns begin

  %= column begin
    %= tag ul => begin
      %= tag li => '...'
    % end
  % end
  %= column begin
    %= ppi 'lib/ActionArg.pm'
  % end

% end


