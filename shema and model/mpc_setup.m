%% create MPC controller object with sample time
mpc1 = mpc(plant_C, 0.05);
%% specify prediction horizon
mpc1.PredictionHorizon = 20;
%% specify control horizon
mpc1.ControlHorizon = 3;
%% specify nominal values for inputs and outputs
mpc1.Model.Nominal.U = [0;0;0;0];
mpc1.Model.Nominal.Y = [0;0;0;0;0;0;0;0;0;0;0;0];
%% specify constraints for OV
mpc1.OV(1).Min = 14;
mpc1.OV(1).Max = 16;
mpc1.OV(3).Min = 9;
mpc1.OV(3).Max = 11;
mpc1.OV(5).Min = 0;
mpc1.OV(5).Max = 6;
mpc1.OV(7).Min = -0.261799387799149;
mpc1.OV(7).Max = 0.261799387799149;
mpc1.OV(9).Min = -0.261799387799149;
mpc1.OV(9).Max = 0.261799387799149;
%% specify weights
mpc1.Weights.MV = [0.1 0.1 0.1 0.1];
mpc1.Weights.MVRate = [0.1 0.1 0.1 0.1];
mpc1.Weights.OV = [1 1 1 1 10 10 10 10 10 10 10 10];
mpc1.Weights.ECR = 100000;
%% specify simulation options
options = mpcsimopt();
options.RefLookAhead = 'off';
options.MDLookAhead = 'off';
options.Constraints = 'on';
options.OpenLoop = 'off';
%% run simulation
sim(mpc1, 201, mpc1_RefSignal, mpc1_MDSignal, options);
