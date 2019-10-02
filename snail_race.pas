program snail_race;
uses crt, sysutils;
const COLORS: array [1..3] of byte = (RED, GREEN, BLUE);
var selected_snail: char;
    snail1: byte = 0;
    snail2: byte = 0;
    snail3: byte = 0;
    random_number: byte;

procedure finish();
begin
     if (keypressed) then
     begin
         if (readkey = #27) then
         begin
             halt(0);
         end;
     end;
end;

procedure draw_lane(line_number, snail: integer; color: byte);
begin
     gotoxy(1, line_number);
     textcolor(LIGHTGRAY);
     write('================================================================================');
     textcolor(color);
     gotoxy(snail, line_number + 1);
     write(' _@~');
end;

procedure draw_racetrack(snail1, snail2, snail3 :integer);
begin
    clrscr();
    write('Racetrack');
    draw_lane(2, snail1, COLORS[1]);
    draw_lane(4, snail2, COLORS[2]);
    draw_lane(6, snail3, COLORS[3]);
    textcolor(lightgray);
    gotoxy(1, 8);
    writeln('================================================================================');
end;

procedure place_tip();
var i: integer;
begin
    clrscr();
    writeln('Snail race.');
    writeln('Place your tip!');
    for i := 1 to 3 do
    begin
        textcolor(LIGHTGRAY);
        write(i, '. ');
        textcolor(COLORS[i]);
        writeln('_@~');
    end;
    textcolor(LIGHTGRAY);
    readln(selected_snail);
    if (selected_snail <> '1') and (selected_snail <> '2') and (selected_snail <> '3') then
    begin
        writeln('Wrong choice.');
        writeln('Hit the ENTER to exit.');
        readln();
        halt(1);
    end;
	writeln('Your tip: ', selected_snail, '. snail');
end;

procedure is_this_snail_won(snail, snail_number: byte; selected_snail: char);
begin
    if (snail = 77) then
    begin
        writeln('The ', snail_number, '. snail won.');
        if (strtoint(selected_snail) = snail_number) then
        begin
            writeln('You won!');
        end
        else
        begin
            writeln('You lost!');
        end;
    end;
end;

procedure who_won();
begin
    is_this_snail_won(snail1, 1, selected_snail);
    is_this_snail_won(snail2, 2, selected_snail);
    is_this_snail_won(snail3, 3, selected_snail);
end;

procedure draw_winner();
begin
    writeln('Ypur tip was the ', selected_snail, '. snail.');
    who_won();
    writeln('To exit push the ENTER button.');
    readln();
end;

begin
    place_tip();
    draw_racetrack(snail1, snail2, snail3);
    repeat
        finish();
		randomize();
		random_number := random(3) + 1;
		case random_number of
		    1: inc(snail1);
		    2: inc(snail2);
		    3: inc(snail3);
		end;
		draw_racetrack(snail1, snail2, snail3);
		delay(500);
    until (snail1 = 77) or (snail2 = 77) or (snail3 = 77);
    draw_winner();
end.
