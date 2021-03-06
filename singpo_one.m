% Singular points caculations(singpo.m)
%Singpo.m sets up GUI for singular points calculations.
%This M-file designed to obtaion singular points after running 
%dynamic bifurcation analysis. One of the algebraic state variables at  time is
%parameterized to search for singular points.

% ****************************************************************************
if exist('dlgfig')
    set(dlgfig,'Visible','off');
end

% Check whether data is loaded or not
%************************************

if ~exist('DataFlag'),DataFlag=0;end
if DataFlag==0,getdata;end;
if DataFlag==0,return;end;
if (strcmp(computer,'SOL2' ))
  mexwild = '*.mexsol';
  lensub=7;
elseif (strcmp(computer, 'PCWIN'))
   mexwild = '*.dll';
    lensub=4;
end

[SPfilename,SPpathname]=uigetfile(mexwild,'choose system for analysis');

% Check the correct .dll file
%********************************

if SPfilename~=0,
    CurrentSystem=SPfilename(1:length(SPfilename)-lensub);
    if isempty(findstr(CurrentFileName,CurrentSystem))
        titleStr=[' Inconsistent Names '];
        textStr=['                                              '
                 ' Names of the data file and executable must   '
                 ' be consistent. Do you want to choose another '
                 ' executable now ?                             '
                ];
        dlgfig=mydlg(titleStr,textStr,'singpo_one | rtnnow')
        return;
    end
    % Define a figure window and assign a handle to it
    % **************************************************
    
    position=get(0,'DefaultFigurePosition');
    position=position-[70 70 0 0];
    singpo_fig=figure(...
        'NumberTitle','off',...
        'Name','Voltage Stability Toolbox - Singular Point Analysis (One dynamic variable)',...
        'Resize','off',...
        'Position',position,...
        'MenuBar','none',...
        'Color',[0.7 0.8 0.9]);
   %********************************************************
% Help menu
% *******************************************************

help_menu=uimenu(singpo_fig,...
    'Label','Help');

    hlp=uimenu(help_menu,...
        'Label','Help',...
        'CallBack','helpfun(singpo_hlpTitle,hlpStr6)');

singpo_hlpTitle=['Voltage Stability Toolbox - Singular Point Computations Help Window'];

% set singular analysis data flag
SP_Data_Flag=0;

% Add the LFpathname to the current path(C:\Saffet\Mat5\vst5_1\models)
% ********************************************************************
path(path,SPpathname);
% Load the CurrentSystem (IEEE#.mat) mat fil
%*********************************************
eval(['load ',CurrentSystem,'.mat']);
  % set initial conditions to the point near bifurcation
    if exist('simul_st_x')
        x=simul_st_x;
    else
        simul_st_x=x;
     end
     if exist('simul_st_p')
        param=simul_st_p;
    else
        simul_st_p=param;
    end

    if ~exist('v')
        v=zeros(size(x));
     end
% Add the title to the singular point Computationswindow (i.e.,Current System:IEEE#) 
%************************************************************************************

    titlepanel;
    
 % Present editable data: states & params
    k_states=length(x);
    k_params=length(param);
    lfmklabl;% Put the initial data and states values from the input
    
    % Default Search Direction
 	%***************************
   a=zeros(size(x));
   
   % Frame
    uicontrol(singpo_fig,...
        'Style','frame',...
        'Background','B',...
        'Position',[25,17,min(max(k_states,k_params),5)*90+10,172]);

    %*********************************
    % State Data Display
    %*********************************
    % Define state slider
    display_length=min(k_states,5);

    sli_states=uicontrol(singpo_fig,...
        'Style','slider',...
        'Position',[30,40,display_length*90,15],...
        'Min',1,'Max',k_states,'Value',1,...
        'Callback','lfsetsta');

    CurrentState=max([1,round(get(sli_states,'Value'))]);

    % State slider text
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[30,23,25,12],...
        'String','1');
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[5+display_length*90,23,25,12],...
        'String',num2str(k_states));
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[display_length*45-15,35,100,15],...
        'BackgroundColor','Y',...
        'String','State Values');
     StateSlider=uicontrol(singpo_fig,...
        'Style','popupmenu',...
        'Position',[display_length*45-15,35,130,15],...
        'BackgroundColor','Y',...
        'String','States Values|Search Direction',...
        'Callback','sppardis');


    for i=1:display_length,
        StateLabel(i)=uicontrol(singpo_fig,...
            'Style','text',...
            'Position',[30+(i-1)*90,80,90,18],...
            'HorizontalAlignment','Center',...
            'String',statename(max(CurrentState-5,0)+i,:));
         
        StateValue(i)=uicontrol(singpo_fig,...
            'Style','edit',...
            'Position',[30+(i-1)*90,60,90,18],...
            'HorizontalAlignment','Center',...
            'String',num2str(x(max(CurrentState-5,0)+i)),...
            'Callback','spparupd');
    end

    %*********************************
    % Parameter Data Display
    %*********************************
    % Define parameter slider
    clear ParamSlider;
    display_length=min(k_params,5);
    sli_params=uicontrol(singpo_fig,...
        'Style','slider',...
        'Position',[30,125,display_length*90,15],...
        'Min',1,'Max',k_params,'Value',1,...
        'Callback','lfsetpar');

    CurrentParam=max([1,round(get(sli_params,'Value'))]);

    % Parameter slider text
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[30,108,25,12],...
        'String','1');
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[5+display_length*90,108,25,12],...
        'String',num2str(k_params));

    for i=1:display_length,
        ParamLabel(i)=uicontrol(singpo_fig,...
            'Style','text',...
            'Position',[30+(i-1)*90,165,90,18],...
            'HorizontalAlignment','Center',...
            'String',paramname(max(CurrentParam-5,0)+i,:));

        ParamValue(i)=uicontrol(singpo_fig,...
            'Style','edit',...
            'Position',[30+(i-1)*90,145,90,18],...
            'HorizontalAlignment','Right',...
            'String',num2str(param(max(CurrentParam-5,0)+i)),...
            'Callback','smparupd');
    end

    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[display_length*45-30,106,150,16],...
        'String','Parameter Values',...
        'BackgroundColor','y');
     
     if exist('PP_nose')
    % Setup frame
    uicontrol(singpo_fig,...
        'Style','frame',...
        'BackgroundColor','b',...
        'Position',[25,310,min(max(k_states,k_params),5)*90+10,44]);

     
     % Define point slider
    [mp,np]=size(PP_nose);
    sli_point=uicontrol(singpo_fig,...
        'Style','slider',...
        'Position',[30,335,400,15],...
        'Min',1,'Max',np,'Value',ncols,...
        'SliderStep',[0.0005 0.01],...
        'Callback','spsetpar');
    % Point slider text
    uicontrol(singpo_fig,...
       'Style','text',...
       'BackgroundColor','Y',...
        'Position',[30,317,25,12],...
        'String','1');
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[140,315,150,15],...
        'BackgroundColor','Y',...
        'String','Current Point Number:');
    pointHandle=uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[291,315,30,15],...
        'BackgroundColor','Y',...
        'String',num2str(simul_pt_idx));
    uicontrol(singpo_fig,...
        'Style','text',...
        'Position',[400,317,30,12],...
        'String',num2str(np));

    
spsetpar;
end



   %*********************************
    % Load Flow Controls
    %*********************************
    % Tolerence
    
    LFAbsTol=.000001;
    LFRelTol=.0001;

    % *************************
    % NR and NRS Step Control	
    % *************************
    % NR and NRS Steps
    
    NR_steps=100;
    NRS_Steps=100;
    % *************************
    % pop-up algortithm selector
    % *************************
    % Choose either Newton-Raphson-Seydel or Newton-Raphson algorithm
    % ****************************************************************
    SP_Alg_List=['spsurf';'spcomp'];
    SP_Alg=SP_Alg_List(1,1:6);
    
    % set up the upper panel in the current sumilation window
    % *********************************************************
    upperpanel_one;

    % Set up the algorithm display
    % ********************************
    
    alg_popup=uicontrol(gcf,...
        'Style','popupmenu',...
        'Position',[30,265,223,18],...
        'HorizontalAlignment','Center',...
        'String','Newton-Raphson-Seydel|Newton-Raphson',...
        'Callback','SP_Alg=SP_Alg_List(get(alg_popup,''Value''),1:6);');
     
  end
  
