#!/bin/ruby
require 'bloops'

note = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
chordkind = {''    => [0, 4, 7],
             'm'    => [0, 3, 7],
             '7'    => [-2, 0, 4, 7],
             'M7'   => [-1, 0, 4, 7],
             'm7'   => [-2, 0, 2, 7],
             'dim'  => [-3, 0, 2, 6],
             'aug'  => [0, 4, 8],
             'sus4' => [0, 5, 7]}
keymap = {'u' => 'G#',
          'i' => 'A',
          'o' => 'A#',
          'p' => 'B',
          'j' => 'C',
          'k' => 'C#',
          'l' => 'D',
          ';' => 'D#',
          'm' => 'E',
          ',' => 'F',
          '.' => 'F#',
          '/' => 'G',
          'w' => 'sus4',
          'e' => 'dim',
          'r' => 'aug',
          'a' => 'M7',
          's' => 'm7',
          'd' => '7',
          'f' => 'm'}

sound = Bloops.new.sound Bloops::SQUARE

chords = Hash::new
for i in 0..11 do
  chordkind.each_key{|kind|
    chords[note[i] + kind] = Bloops.new
    chords[note[i] + kind].tempo = 50
    chordkind[kind].each{|tone|
      chords[note[i] + kind].tune sound, note[(i + tone) % 12]
    }
  }
end

bef = 'j'
while true
  input = gets.chop
  now = ""
  input.split(//).each{|key|
    if keymap.include?(key) then
      now += keymap[key]
    end
  }
  unless chords.include?(now) then
    now = bef
  end
  p now
  chords[now].play
  bef = now
end
