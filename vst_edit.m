% Sets up GUI for editing power system data base.


% Load the VST data if not loaded already
% ==========================================
if ~exist('DataFlag'),DataFlag=0;end
if DataFlag==0,getdata;end
if DataFlag==0,return;end

% Open a figure window 
% ============================================
position=get(0,'DefaultFigurePosition');
position=position-[70 70 0 0];
edit_fig=figure(...
    'NumberTitle','off',...
    'Name','Voltage Stability Toolbox - Power System Data',...
    'Resize','off',...
    'Position',position,...
    'Color',[0.7 0.8 0.9],...
    'MenuBar','none');  % EDITED BY: Vedanshu

% ==============================
% Help menu
% helpmenu=uimenu(edit_fig,...
%     'Label','Help');  % EDITED BY: Vedanshu

    %hlp=uimenu(helpmenu,...
    %    'Label','Help',...
     %   'CallBack','helpfun(edit_hlpTitle,hlpStr6)');

edit_hlpTitle=['Voltage Stability Toolbox - Edit Window Help'];

% ===============================
% System data file name
uicontrol(edit_fig,...
    'Style','frame',...
    'Position',[127,335,236,28],...
    'BackgroundColor','r');

uicontrol(edit_fig,...
    'Style','text',...
    'BackgroundColor',[0.8 0.8 0.8],...
    'Position',[130,338,230,22],...
    'HorizontalAlignment','Center',...
    'String',['Current Data File: ',CurrentFileName]);

% ===============================
% Control buttons
	 
%***************************%
% Save/Save As push buttons %
%***************************%
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[160,295,60,25],...
    'HorizontalAlignment','Center',...
    'BackgroundColor','r',...
    'String','Save',...
    'CallBack','savedata(NumBus,bus_data,NumBranch,branch_data,CurrentPath,CurrentFileName)');
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[260,295,60,25],...
    'HorizontalAlignment','Center',...
    'BackgroundColor','r',...
    'String','Save As',...
    'CallBack','savasdat');


%================================
% Frame for all edit fields
uicontrol(edit_fig,...
    'Style','frame',...
    'Position',[25,11,471,272],...
    'BackgroundColor','b');


% ===============================
% Edit fields for bus data

% Define bus slider
sli_bus=uicontrol(edit_fig,...
    'Style','slider',...
    'Position',[30,52,140,16],...
    'Min',1,'Max',NumBus,'Value',1,...
    'CallBack','busdata');
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[30,36,25,14],...
    'String','1');
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[145,36,25,14],...
    'String',num2str(NumBus));
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[55,16,90,15],...
    'String','Bus Data');	 	 

CurrentBus=max([1,round(get(sli_bus,'Value'))]);

bus_cur=uicontrol(edit_fig,...
    'Style','text',...
    'Position',[87,36,25,14],...
    'BackgroundColor','Y',...
    'String',num2str(CurrentBus));
 
% There is no callback for push button 'add'
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[45,70,55,18],...
    'HorizontalAlignment','Center',...
    'String','Add');
 
 % There is no callback for push button 'delete'
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[101,70,55,18],...
    'HorizontalAlignment','Center',...
    'String','Delete');

top=260;
left=30;
w1=55;
w2=left+w1;
w3=85;
h1=18;
h2=20;

% Bus Name	 
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[left,top,w1,h1],...
    'HorizontalAlignment','Left',...
    'String',' Name:');
BusName=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','Left',...
	 'String',bus_name(CurrentBus,:),...
	 'CallBack','busdef');

% Bus Type
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Type:');
BusType=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','center',...
	 'String',num2str(bus_type(CurrentBus)),...
	 'CallBack','busdef');

% Bus Powers
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' P:');
BusP=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','center',...
	 'String',num2str(bus_p(CurrentBus)),...
	 'CallBack','busdef');

top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Q:');
BusQ=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','center',...
	 'String',num2str(bus_q(CurrentBus)),...
	 'CallBack','busdef');

% Shunt Admittance	 
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Cond.:');
Conductance=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','center',...
	 'String',num2str(bus_condc(CurrentBus)),...
	 'CallBack','busdef');

top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Susc.:');
Susceptance=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','center',...
	 'String',num2str(bus_suscp(CurrentBus)),...
	 'CallBack','busdef');

%*******************%
% Bus Actions       %
%*******************%
% Merge
top=top-2*h2;
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[left,top,w1,h1+h2],...
    'HorizontalAlignment','Center',...
    'String','Merge');
MergeBus1=uicontrol(edit_fig,...
    'Style','edit',...
    'Position',[w2,top+h2,w3,h1],...
    'HorizontalAlignment','right',...
    'String',bus_name(CurrentBus,:));
MergeBus2=uicontrol(edit_fig,...
    'Style','edit',...
    'Position',[w2,top,w3,h1],...
    'HorizontalAlignment','right',...
    'String',bus_name(CurrentBus,:));

% Find Bus
top=top-h2;
uicontrol(edit_fig,...
     'Style','push',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Find',...
	 'CallBack','find_bus');
FindBus=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',bus_name(CurrentBus,:)...
	 );

% ==============================
% Edit fields for branch data

% Define branch slider
sli_branch=uicontrol(edit_fig,...
    'Style','slider',...
    'Position',[185,52,140,16],...
    'Min',1,'Max',NumBranch,'Value',1,...
    'CallBack','brnchdat');

% Branch Slider
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[185,36,25,14],...
    'String','1');
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[300,36,25,14],...
    'String',num2str(NumBranch));
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[210,16,90,15],...
    'String','Branch Data');	 	 

CurrentBranch=max([1,round(get(sli_branch,'Value'))]);

branch_cur=uicontrol(edit_fig,...
    'Style','text',...
    'Position',[245,36,25,14],...
    'BackgroundColor','Y',...
    'String',num2str(CurrentBranch));

uicontrol(edit_fig,...
   'Style','push',...
   'BackgroundColor','r',...
    'Position',[199,70,55,18],...
    'HorizontalAlignment','Center',...
    'String','Add');
uicontrol(edit_fig,...
    'Style','push',...
    'Position',[255,70,55,18],...
    'HorizontalAlignment','Center',...
    'String','Delete');

top=260;
left=185;
w2=left+w1;

% Tap Bus
uicontrol(edit_fig,...
    'Style','text',...
    'Position',[left,top,w1,h1],...
    'HorizontalAlignment','Left',...
    'String',' From:');
BranchTapBus=uicontrol(edit_fig,...
    'Style','edit',...
    'Position',[w2,top,w3,h1],...
    'HorizontalAlignment','Right',...
    'String',num2str(tap_bus(CurrentBranch)),...
    'CallBack','brnchdef');

% Z bus
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' To:');
BranchZBus=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','Right',...
	 'String',num2str(z_bus(CurrentBranch)),...
	 'CallBack','brnchdef');

% Branch Type
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' Type:');
BranchType=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(trans_type(CurrentBranch)),...
	 'CallBack','brnchdef');

% Branch Resistance
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' R:');
BranchResistance=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(brch_r(CurrentBranch)),...
	 'CallBack','brnchdef');

% Branch Reactance
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String',' X:');
BranchReactance=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(brch_x(CurrentBranch)),...
	 'CallBack','brnchdef');

% Controlled Bus Number
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','CtrlBus:');
ControlledBus=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(cnrl_bus_nmbr(CurrentBranch)),...
	 'CallBack','brnchdef');

% Minimum Tap
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','MinTap:');
MinimumTap=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(min_tp_shft(CurrentBranch)),...
	 'CallBack','brnchdef');

% Maximum Tap
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','MaxTap:');
MaximumTap=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(max_tp_shft(CurrentBranch)),...
	 'CallBack','brnchdef');

% Tap Step Size	
top=top-h2; 
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','TapStep:');
TapStep=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(step_size(CurrentBranch)),...
	 'CallBack','brnchdef');


% =================================
% Edit fields for generator data

% Define generator slider
sli_gen=uicontrol(edit_fig,...
     'Style','slider',...
	 'Position',[340,52,150,16],...
	 'Min',1,'Max',NumGen,'Value',1,...
	 'CallBack','gendata');
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[340,36,25,14],...
	 'String','1');
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[465,36,25,14],...
	 'String',num2str(NumGen));
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[365,16,100,15],...
	 'String','Generator Data');	 	 

CurrentGen=max([1,round(get(sli_gen,'Value'))]);

gen_cur=uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[402,36,25,14],...
	 'BackgroundColor','Y',...
	 'String',num2str(CurrentGen));
	 
%*************************%
% Generator Actions       %
%*************************%
uicontrol(edit_fig,...
     'Style','push',...
	 'Position',[367,70,50,18],...
	 'HorizontalAlignment','Center',...
	 'String','Add');
uicontrol(edit_fig,...
     'Style','push',...
	 'Position',[418,70,50,18],...
	 'HorizontalAlignment','Center',...
	 'String','Delete');

top=260;
left=340;
w1=60;
w2=left+w1;
w3=90;

% Generator Inertia
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','Inertia:');
GenInertia=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(gen_inertia(CurrentGen)),...
	 'CallBack','gendef');

% Generator damping
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','Damping:');
GenDamp=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(gen_damp(CurrentGen)),...
	 'CallBack','gendef');

% Branch
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','Branch:');
GenBranch=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(gen_branch(CurrentGen)));

% Controlled Bus
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','BusR:');
ControlBusName=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(bus_R(CurrentGen)),...
	 'CallBack','gendef');

% Excitor Volatage Limits
top=top-h2;
w3=w3/2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','max/min:');
VoltageLimitMax=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(VRmax(CurrentGen)),...
	 'CallBack','gendef');
VoltageLimitMin=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2+w3,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(VRmin(CurrentGen)),...
	 'CallBack','gendef');

% Excitor Compensator
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','KA/TA:');
ExcitorCompKA=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExKA(CurrentGen)),...
	 'CallBack','gendef');
ExcitorCompTA=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2+w3,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExTA(CurrentGen)),...
	 'CallBack','gendef');

% Excitor Stabilizer
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','KF/TF:');
ExcitorStabKF=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExKF(CurrentGen)),...
	 'CallBack','gendef');
ExcitorStabTF=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2+w3,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExTF(CurrentGen)),...
	 'CallBack','gendef');
	 
% ExcitorDyn
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','KE/TE:');
ExcitorDymKE=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExKE(CurrentGen)),...
	 'CallBack','gendef');
ExcitorDymTE=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2+w3,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExTE(CurrentGen)),...
	 'CallBack','gendef');

% Excitor Saturation
top=top-h2;
uicontrol(edit_fig,...
     'Style','text',...
	 'Position',[left,top,w1,h1],...
	 'HorizontalAlignment','Left',...
	 'String','AEX/BEX:');
ExcitorSatAEX=uicontrol(edit_fig,...
     'Style','edit',...
	 'Position',[w2,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExAEX(CurrentGen)),...
	 'CallBack','gendef');
ExcitorSatBEX=uicontrol(edit_fig,...
    'Style','edit',...
	 'Position',[w2+w3,top,w3,h1],...
	 'HorizontalAlignment','right',...
	 'String',num2str(ExBEX(CurrentGen)),...
	 'CallBack','gendef');