# Processing Data from Chip Measurements
The provided MATLAB scripts are used to process the data collected from passive photonic devices - specifically my photonic crystal-based polarization beam splitter - as well as other test structures on the chip.

## Description
A full analysis of the photonic chip includes a calculation of the wire waveguide loss using measurements of transmission for wire waveguides of different path lengths. Photonic crystals with no defects are added as test structures to observe whether or not the lattice reflects TE light - this is seen as a drop in TE transmission. Similarly, a stop band can also be observed in a W1 photonic crystal (W1 indicates the removal of 1 row of holes creating a path through the lattice effectively acting as a waveguide). By adding in a line defect to the photonic crystal it is expected that the band edges of the photonic crystal's stop band will shift. Finally, the actual device being tested is a polarizaiton beam splitter (PBS). This is a device intended to separate TE and TM polarizations - typical for coherent communication systems applications. The PBS devices have two outputs corresponding to either polarization. In order to confirm splitting, the code calculates an extinction ratio which describes the amount of polarized light in either output. For all devices measured, there is data for both TE and TM.

## Dependencies
MATLAB R2022b or later required.
