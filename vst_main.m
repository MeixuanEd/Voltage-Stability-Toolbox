



% VST_MAIN	Main Program of Voltage Stability Toolbox (VST).
% 		VST_MAIN displays welcome message and sets up menus. 
%

% There are four menus 1) Model, 2) Analysis, 3) Edit, and 4) Help

% =================================================================
% Clear all windows, variables, etc.
clc;
clear all;  % EDITED BY: Vedanshu
close all;


% =================================================================
% Set data-loaded flag: 0 - no data loaded
DataFlag=0;


% =================================================================
% Create main window, menus, and menuitems

% -------------------------------------------------
% Initialize default figure variables
position=get(0,'DefaultFigurePosition');
position=position-[20 20 0 0];
Main_Fig=figure(...
    'NumberTitle','off',...
    'Name','Voltage Stability Toolbox',...
    'Color',[0.7 0.8 0.9],...
    'Pointer','watch',...
    'Position',position,...
    'Resize','off',...
    'MenuBar','none');  % When MenuBar is none, uimenus are the only items on the menu bar (that is, the built-in menus do not appear).
                        % EDITED BY: Vedanshu

% -------------------------------------------------
% MODEL MENU
Model_Menu=uimenu(Main_Fig,...
    'Label','Model');

    % Import menuitem
    import=uimenu(Model_Menu,...
        'Label','Import');

        statieee=uimenu(import,...
            'Label','IEEE Static',...
            'CallBack','imptieee');

        dynaieee=uimenu(import,...
            'Label','IEEE Dynamic',...
            'Enable','off');

    
    % Load menuitem
    open_db=uimenu(Model_Menu,...
        'Label','Load',...
        'Separator','on',...
        'Callback','getdata');


    % Build menuitem
    build_model=uimenu(Model_Menu,...
        'Label','Build',...
        'Separator','on');
% this was off before, I made it on
        nmc=uimenu(build_model,...
            'Label','Network Model C',...
            'CallBack','C_Flag=1;eqmodel(bus_type,bus_condc,bus_suscp,NumBus,tap_bus,z_bus,brch_r,brch_x,NumBranch,C_Flag);',...
            'Enable','on');
% this was off before, I made it on
        nmm=uimenu(build_model,...
            'Label','Network Model Maple',...
            'CallBack','C_Flag=0;eqmodel(bus_type,bus_condc,bus_suscp,NumBus,tap_bus,z_bus,brch_r,brch_x,NumBranch,C_Flag);',...
            'Enable','on');

        pocm=uimenu(build_model,...
           'Label','Classical PoC',...
           'CallBack','mex_poc');
    

            


    % Compile menuitem
    compile_model=uimenu(Model_Menu,...
        'Label','Compile',...
        'CallBack','mex_cmpl');

% -------------------------------------------------
% ANALYSIS MENU
Analysis_Menu=uimenu(Main_Fig,...
    'Label','Analysis');

    % Load Flow menuitem
    load_flow=uimenu(Analysis_Menu,...
        'Label','Load Flow');

        snrm=uimenu(load_flow,...
            'Label','Standard NR',...
            'CallBack','loadflow');

        %convm=uimenu(load_flow,...
           %'Label','Convergent (NRS)',...
        %'Callback','conv_loadflow');

	% Simulation menuitem
	simulate=uimenu(Analysis_Menu,...
      'Label','Simulation',...
      'CallBack','sim_0');
     
     % Static Bifurcation menuitem
    static_bif=uimenu(Analysis_Menu,...
        'Label','Static Bifurcation',...
        'Separator','on',...
        'Callback','statbif');

    % Dynamic Bifurcation menuitem
    	dynamic_bif=uimenu(Analysis_Menu,...
        'Label','Dynamic Bifurcation Analysis');
        
        z_bif=uimenu(dynamic_bif,...
        'Label','Zoom around nose point ',...
        'Callback','dynabif');
        
        low_bif=uimenu(dynamic_bif,...
        'Label','Zoom Lower Part',...
        'Callback','ldynabif');
                
        % Eigenvalues of the system matrix, Asys (which is a reduced system)
       eig_loc=uimenu(Analysis_Menu,...
          'Label','Eigenvalue of system matrix',...);
          'Callback','chlpe');
       
    % Sensitivity information obtain from left and right eigencevtor at the point of collapse point
    sensitivity=uimenu(Analysis_Menu,...
       'Label','Sensitivity around saddle node bifurcation',...);
          'Callback','eigen_vec');
    % Singular point calculations menuitems
    	sing_point=uimenu(Analysis_Menu,...
        'Label','Singular Point Analysis');
        
%        sing_NRS=uimenu(sing_point,...
%           'Label','NRS only (upper)',...
%           'CallBack','singpo_NRS');

        
         sing_NR_NRS=uimenu(sing_point,...
        'Label','NR and NRS ',...
        'Callback','singpo_NR_NRS');
        
        

    % -------------------------------------------------
% EDIT MENU
% Edit menuitem
    Edit_Menu=uimenu(Main_Fig,...
        'Label','Edit');
	
	% Edit VST Data Menuitem
    edit_db=uimenu(Edit_Menu,...
    	'Label','Edit VST Data',...
    	'Callback','vst_edit');
    	
%----------------------------------------------------
    	
% Help menu
helpmenu=uimenu(Main_Fig,...
    'Label','Help');

    hlp=uimenu(helpmenu,...
        'Label','Help',...
        'Separator','on',...
        'CallBack','helpfun(hlpTitle,hlpStr1,hlpStr2,hlpStr3,hlpStr4,hlpStr5)');

	abTitle=['Voltage Stability Toolbox - About VST'];
	aboutStr=[
        '                                               '
        ' Voltage Stability Toolbox  Version 2.0        '
        '                                               '
        ' Copyright (c) 1999, CEPE, Drexel University   '
        '                                               '
        ' Center for Electric Power Engineering         '
        ' Drexel University                             '
        ' Philadelphia, PA 19104                        '
        ' Phone:(215) 895 1466                          '
        ' Fax  :(215) 895 6766                          '
        '                                               '
        ' Contact Information:                          '
        ' Saffet Ayasun                                 '
        ' Email: ayasun@cbis.ece.drexel.edu             '
        '                                               '
        ' Chika Nwankpa                                 '
        ' Email: chika@nwankpa.ece.drexel.edu           '
        '                                               '
        ' Vedanshu                                      '
        ' Email: anshgravity@gmail.com                  '
       ];

about=uimenu(helpmenu,...
        'Label','About',...
        'CallBack','helpfun(abTitle,aboutStr)');

hlpTitle=['Voltage Stability Toolbox -  Help Window'];
hlpStr1=['                                                                             '
         '   Voltage Stability Toolbox                                                 '
         '                                                                             '
         '   Voltage Stability Toolbox (VST) is a powerful software package, developed '        
         '   in Center for Electric Power Engineering, Drexel University, to analyze   '
         '   voltage stability phenomena and provide intuitive information for power   '
         '   system planning, operation,and control. It can also be used to implement  '
         '   load flow calculations. VST is a portable software package that combines  '
         '   computational and analytical capabilities of bifurcation theory, and      '
         '   symbolic implementation and graphical representation capabilities of      '
         '   MATLAB and its Toolboxes.                                                 '
         '                                                                             '
         '   The following analyis can be using VST:                                   '                                                       
         '                                                                             '
         '   Load flow analysis                                                        '
         '                                                                             ' 
         '   Time domain dynamic analysis                                              '
         '                                                                             '
         '   Static bifurcation analysis                                               '
         '                                                                             '
         '   Dynamic bifurcation analyis                                               '
         '                                                                             '
         '   Eigenvalue analysis                                                       '
        ];
hlpStr2=[     																							                 
   	                                                                              
        	'  LOAD FLOW ANALYSIS                                                         '
        	'                                                                             '
        	'  To run the Load Flow, follow the steps below:                              '
        	'                                                                             '
        	'  Select Model/Load to load the IEEE#_VST.dat                                '
        	'                                                                             '
        	'  Select one of the IEEE#_VST.dat file from the data folder to load the data '
        	'                                                                             '
        	'  Select Analysis/Load Flow/Standard NR                                      '
        	'                                                                             '
        	'  Select the corresponding IEEE#.mexw32 file from the models folder          '
        	'                                                                             '
        	'  This will bring the Load Flow Analysis window                              '
        	'                                                                             '
        	'  Reset the states values (flat start)                                       '
        	'                                                                             '
        	'  Start the program to obtain load flow results                              '
        	'                                                                             '
        	'  Parameter values are the net injections at each bus                        '
        	'                                                                             '
        	'  State values are the voltage magnitudes and angles at each bus             '
        ];
hlpStr3=[
        '                                                                           '
        ' TIME DOMAIN DYNAMIC SIMULATION ANALYSIS                                   '
        '                                                                           '
        'To run the time domain simulations, follow the steps below                 '
        '                                                                           '                                                                      
        'Select Model/Load                                                          '
        '                                                                           '
        'Select one of the IEEE#_VST.dat file in the data folder to load the data   '
        '                                                                           '
        'Run the dynamic bifurcation anlysis first to load the initial data         '
        '                                                                           '
        'Select Analysis/Simulation                                                 '
        '                                                                           '
        'Select the corresponding IEEE#.mexw32 file in the models folder            '
        '                                                                           '
        'This will bring time domain simulation window                              '
        '                                                                           '
        'Select the duration of the simualtion                                      '
        '                                                                           '
        'Choose the initial operating point for the simulation                      '
        '                                                                           '
        'Run the program by pushing the Start button                                '
        '                                                                           '
        'Select the generator variable to plot                                      '


       ];
       
hlpStr4=[
        ' STATIC BIFURCATION ANALYIS                                                               '
        '                                                                                          '
        'To run the static bifurcation simulation, follow the steps below:                         '                                                       
        '                                                                                          '
        'Select Model/Load                                                                         '
        '                                                                                          '
        'Select one of the IEEE#_VST.dat file in the data folder to load the data                  '
        '                                                                                          '
        'Select Analyis/Static Bifurcation                                                         '
        '                                                                                          '
        'Select the corresponding IEEE#.mexw32 file in the models folder                           '
        '                                                                                          '
        'This will bring static bifurcation  simulation interface                                  '
        '                                                                                          '
        'Reset the sate values (flat start)                                                        '
        '                                                                                          '
        
        'Set search direction to (-1) for load buses to increase the power demand                  '
        '                                                                                          '
        'Set search direction to 1 for generator buses to increase the generation                  '
        '                                                                                          '
        'Start the program                                                                         '
        '                                                                                          '
        'The output of this simulation is the bifurcation surface(nose curve)                      '
        '                                                                                          '
        'Select any state variable from the slider to plot                                         '
       ];
hlpStr5=[
        '                                                                                           '
        ' DYNAMIC BIFURCATION ANALYIS                                                               '
        '                                                                                           '
        'To run the dynamic bifurcation simulation, follow the steps below:                         '                                                       
        '                                                                                           '
        'Select Model/Load                                                                          '
        '                                                                                           '
        'Select one of the IEEE#_VST.dat file in the data folder to load the data                   '
        '                                                                                           '
        'Select Analyis/Dynamic Bifurcation                                                         '
        '                                                                                           '
        'Select the corresponding IEEE#.mexw32 file in the models folder                            '
        '                                                                                           '
        'This will bring dynamic bifurcation  simulation interface                                  '
        '                                                                                           '
        'Reset the sate values (flat start)                                                         '
        '                                                                                           '
     
        'Set search direction to (-1) for load buses to increase the power demand                   '
        '                                                                                           '
        'Set search direction to 1 for generator buses to increase the generation                   '
        '                                                                                           '
        'Start the program                                                                          '
        '                                                                                           '
        'The output of this simulation is the bifurcation surface(nose curve)                       '
                                                                                                  
        


];
hlpStr6=[
        '                                                                                           '
        ' SINGULAR POINT COMPUTATIONS                                                               '
        '                                                                                           '
        'To run the dynamic bifurcation simulation, follow the steps below:                         '                                                       
        '                                                                                           '
        'Select Model/Load                                                                          '
        '                                                                                           '
        'Select one of the IEEE#_VST.dat file in the data folder to load the data                   '
        '                                                                                           '
        'Select Analyis/Dynamic Bifurcation                                                         '
        '                                                                                           '
        'Select the corresponding IEEE#.mexw32 file in the models folder                            '
        '                                                                                           '
        'This will bring dynamic bifurcation  simulation interface                                  '
        '                                                                                           '
        'Reset the sate values (flat start)                                                         '
        '                                                                                           '
     
        'Set search direction to (-1) for load buses to increase the power demand                   '
        '                                                                                           '
        'Set search direction to 1 for generator buses to increase the generation                   '
        '                                                                                           '
        'Start the program                                                                          '
        '                                                                                           '
        'The output of this simulation is the bifurcation surface(nose curve)                       '
                                                                                                  
        


    ];


% -------------------------------------------------
% Display welcome message
mylogo;
uicontrol(Main_Fig,... 
    'Style','text',...
    'Position',[50,48,500,22],...
    'BackgroundColor','w',...
    'String','Maintained BY:',...
    'FontSize',15)

uicontrol(Main_Fig,... 
    'Style','text',...
    'Position',[50,27,500,22],...
    'BackgroundColor','w',...
    'String','Vedanshu',...
    'FontSize',15)

uicontrol(Main_Fig,... 
    'Style','text',...
    'Position',[50,7,500,22],...
    'BackgroundColor','w',...
    'String','B K Birla Institute of Technology and Science, Pilani',...
    'FontSize',15)

axis off;
set(gca,'Position',[0.275 0.25 0.5 0.4]);

cplxroot(3,15);
orbit(15);
axis off;

set(Main_Fig,'Pointer','arrow');

