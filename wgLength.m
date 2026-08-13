function wgOut = wgLength(a, Nx)
%wgLength Calculate length of wire waveguide
%   The actual length of the waveguide depends on the length of the ECs and
%   the PhC structures - which in turn is affected by the lattice constant
%   and number of rows used. This function simply takes these factors into
%   account to calculate a more accurate waveguide length for use in the
%   wave guide loss calculation. Since there is an additional bend in the
%   input waveguides, we calculated the hypotenuese between the start and
%   end points of the bend (=14.14um).

% Calculate wg length based on the specific device being tested
% EC length and bend accounted for
if Nx == 20
    wg = 995 + 14.14 + 448.5 + 1458.5; % um
elseif Nx ==30
    wg = 995 + 14.14 + 448.5 + 1454.5; % um
else
    if a == 380
        wg = 995 + 14.14 + 448.5 + 1456.7; % um
    elseif a == 400
        wg = 995 + 14.14 + 448.5 + 1456.3; % um
    else
        wg = 995 + 14.14 + 448.5 + 1456.5; % um
    end
end

% convert to mm
wgOut = wg/1000;
end