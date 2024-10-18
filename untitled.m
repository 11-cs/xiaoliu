function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 05-Jun-2024 17:02:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;
clc;
% 设置界面标题
set(hObject,'name','刀具标定系统');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
global stopnum 
stopnum = 1;
%% 打开视频
% 清空重置显示屏
cla(handles.axes1,'reset');
set(handles.axes1,'Color',[1,1,1]);
set(handles.axes1,'XTickLabel',[]);
set(handles.axes1,'YTickLabel',[]);
set(handles.axes1,'Box','on');

cla(handles.axes2,'reset');
set(handles.axes2,'Color',[1,1,1]);
set(handles.axes2,'XTickLabel',[]);
set(handles.axes2,'YTickLabel',[]);
set(handles.axes2,'Box','on');

cla(handles.axes3,'reset');
set(handles.axes3,'Color',[1,1,1]);
set(handles.axes3,'XTickLabel',[]);
set(handles.axes3,'YTickLabel',[]);
set(handles.axes3,'Box','on');

cla(handles.axes4,'reset');
set(handles.axes4,'Color',[1,1,1]);
set(handles.axes4,'XTickLabel',[]);
set(handles.axes4,'YTickLabel',[]);
set(handles.axes4,'Box','on');

cla(handles.axes5,'reset');
set(handles.axes5,'Color',[1,1,1]);
set(handles.axes5,'XTickLabel',[]);
set(handles.axes5,'YTickLabel',[]);
set(handles.axes5,'Box','on');

cla(handles.axes6,'reset');
set(handles.axes6,'Color',[1,1,1]);
set(handles.axes6,'XTickLabel',[]);
set(handles.axes6,'YTickLabel',[]);
set(handles.axes6,'Box','on');

cla(handles.axes8,'reset');
set(handles.axes8,'Color',[1,1,1]);
set(handles.axes8,'XTickLabel',[]);
set(handles.axes8,'YTickLabel',[]);
set(handles.axes8,'Box','on');

cla(handles.axes9,'reset');
set(handles.axes9,'Color',[1,1,1]);
set(handles.axes9,'XTickLabel',[]);
set(handles.axes9,'YTickLabel',[]);
set(handles.axes9,'Box','on');

global video_obj;
%选择摄像头和摄像头配置
video_obj = videoinput('winvideo', 1, 'YUY2_640x480');
%设置图像格式为RGB
set(video_obj,'ReturnedColorSpace','rgb');
%获取视频输入对象的信息，用于在坐标区1显示
videoRes = get(video_obj, 'VideoResolution');%获取高度、宽度信息
nBands = get(video_obj, 'NumberOfBands');%获取图像彩色通道数
%转换，将视频输入对象与坐标区1控件关联起来
hImage = image(zeros(videoRes(2), videoRes(1), nBands),'parent',handles.axes1);%指定图像显示在axes1中

preview(video_obj,hImage);
start(video_obj);

set(handles.edit14,'string','摄像头开启','FontSize',16);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%关闭摄像头
global video_obj;
stop(video_obj);
closepreview(video_obj);
delete(video_obj);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global video_obj
global mypic

mypic = getsnapshot(video_obj);%捕获当前帧
axes(handles.axes2);
imshow(mypic);%在axes2中显示出来

title('截取当前帧','FontSize',16);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global mypic   

Image=mypic;
ImageA=Image(:,:,1);
ImageA=ImageA(100:300,:);
    
ImageB=Image(:,:,2);
ImageB=ImageB(100:300,:);
    
ImageC=Image(:,:,3);
ImageC=ImageC(100:300,:);
    
Image=cat(3,ImageA,ImageB,ImageC);%通过对RGB三通道截取100到300行数据组成新的图像

axes(handles.axes3)
imshow(Image)
imwrite(Image,['分帧/','.jpg']);%将上述截取图像放入‘分帧’文件夹并保存为jpg格式

title('保留主要测量区域','FontSize',16);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global stopnum 

Image=imread(strcat('分帧\','.jpg'));%从分帧文件夹中读取图像 

 axes(handles.axes4)
 imshow(Image);
 
%进行阈值分割    

% Define thresholds for channel 1 based on histogram settings
channel1Min = 128.000;
channel1Max = 192.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 26.000;
channel2Max = 57.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 13.000;
channel3Max = 95.000;

I_bw = (Image(:,:,1) >= channel1Min ) & (Image(:,:,1) <= channel1Max) & ...
(Image(:,:,2) >= channel2Min ) & (Image(:,:,2) <= channel2Max) & ...
(Image(:,:,3) >= channel3Min ) & (Image(:,:,3) <= channel3Max);
   
axes(handles.axes5)
imshow(I_bw);
title('分割图','FontSize',16);

%腐蚀，相当于让线条更细，细到没有
se=[1;1;1]; 
I_bw1=imerode(I_bw,se);
%膨胀
se=strel('disk',4);%生成圆形结构元素
I_bw2=imdilate(I_bw1,se); 
%去除小面积干扰，面积阈值为500
I_bw3=bwareaopen(I_bw2,500);    
axes(handles.axes6)
imshow(I_bw3);
title('去除干扰','FontSize',16);

%在图像上绘制出连通域的矩形框
STATS = regionprops(I_bw3,'all');%返回所有可用的区域属性
axes(handles.axes4)
hold on   
title('质心定位','FontSize',16);
          
    for kkk = 1 : size(STATS, 1)%从1到STATS结构体所含连通区域的数量
        boundary = STATS(kkk).BoundingBox;% 获取当前连通区域的边界框  
        rectangle('Position',boundary,'edgecolor','y' );% 绘制边界框，使用黄色边缘  
        a=boundary(1);% 矩形左上角的x坐标  
        b=boundary(2);% 矩形左上角的y坐标
        c=boundary(3);% 矩形的宽度 
        d=boundary(4);% 矩形的高度 
        X=a+0.5*c;
        Y=b+0.5*d;
        plot(X, Y,'b*')%用蓝色*号把质心绘制出来
        
        
        if kkk==1
            global X1;
            global Y1;
            X1=X;
            Y1=Y;
            x1=X1/15;%转换为实际坐标
            y1=Y1/15;
            set(handles.edit1,'string',x1);
            set(handles.edit2,'string',y1);
            centroid1 = [x1,y1]; % 质心坐标，x1和y1是计算出来的质心实际坐标值
            text(X1, Y1-30, sprintf('(%.1f, %.1f)',centroid1), 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心下方显示坐标信息
            %txt = '(x1,y1) \rightarrow';
            %txt = ['(' num2str(center1) ')'];
            %text(X,Y,txt,'Color', 'red', 'FontSize',12,'HorizontalAlignment', 'right')
            
 
        else kkk==2
            global X2;
            global Y2;
            X2=X;
            Y2=Y;
            x2=X2/15;
            y2=Y2/15;
            set(handles.edit3,'string',x2);
            set(handles.edit4,'string',y2);
            centroid2 = [x2,y2]; % 质心坐标，x2和y2是计算出来的质心实际坐标值
            text(X2, Y2+30, sprintf('(%.1f, %.1f)', centroid2), 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心上方显示坐标信息
            %txt = '(x2,y2) \lefttarrow';
            %txt = ['(' num2str(center2) ')'];
            %text(X,Y,txt,'Color', 'red', 'FontSize',12,'HorizontalAlignment', 'left');
           
            plot([X1, X2], [Y1, Y2], 'y-', 'LineWidth', 2); %在两质心之间用黄色的直线连接
        end                
        
    end    
    
    %判别
    global X1;
    global Y1;
    global X2;
    global Y2;
    a1=str2num(get(handles.edit1,'String'));
    a2=str2num(get(handles.edit2,'String'));
    a3=str2num(get(handles.edit3,'String'));
    a4=str2num(get(handles.edit4,'String'));
    disp('距离');
    ddd=sqrt(     (a1-a3).^2  +  (a2-a4).^2       ); %勾股定理
    txt = ['距离为：',num2str(ddd),'mm'];
    X3=(X1+X2)/2;
    Y3=(Y1+Y2)/2;
    text(X3, Y3-60, txt, 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心上方显示坐标信息
    %ddd=ddd/15;%像素和实际距离的关系，大概10个像素点是1mm
    set(handles.edit5,'string',ddd);
     if ddd<5 %小于5mm预警
        set(handles.edit6,'string','靠近注意');
        [filex,fs]=audioread('滴.wav');%导入音频信息
        sound(filex,fs);%播放音频
    else
        set(handles.edit6,'string','安全距离');
    end    
    
    pause(1);
    if stopnum == 1
        pushbutton3_Callback(hObject, eventdata, handles);
        pushbutton4_Callback(hObject, eventdata, handles);
        pushbutton5_Callback(hObject, eventdata, handles);%循环调用三个按钮
    end
    

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%停止调用按钮
global stopnum 
stopnum  = 2
% clc 
% close all

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%视频文件处理部分
global video_obj;
global vidRes;
global writerObj;


writerObj = VideoWriter('C:\Users\ChangshengLiu\Desktop\实时自动跟踪\录制\2 .mp4');%创建保存路径
writerObj.FrameRate =10;%每秒10帧
vidRes=get(video_obj,'VideoResolution');%视频分辨率
width=vidRes(1);%宽
height=vidRes(2);%高
nBands=get( video_obj,'NumberOfBands');%色彩数目
open(writerObj);

for ii = 1: 3000
    frame =getsnapshot(video_obj);
    %frame=ycbcr2rgb(frame);
    f.cdata = frame;
    f.colormap = [];
    writeVideo(writerObj,f);
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global writerObj;
close(writerObj); % 关闭VideoWriter


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global video;
global img_height;
global img_width;
% 打开对话框，选择视频
[FileName, FilePath] = uigetfile({'*.avi;*.mp4;*.mov';'*.*'},'打开视频文件');
% 载入视频路径
if(FileName > 0)
    str = [FilePath FileName];
else
    return;
end
% 根据路径读入视频
video = VideoReader(str);
axes(handles.axes8);
I = read(video,1);
imshow(I);%显示
% 获取视频画面大小信息（宽高）
img_height = size(I,1);
img_width = size(I,2);
%显示总数
numFrames = video.NumberOfFrames;
set(handles.edit16,'string',numFrames);
set(handles.edit18,'string','视频选择完毕');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit18,'string','分帧开始');

frame_num = 0;
a=str2num(get(handles.edit15,'String'));
b=str2num(get(handles.edit16,'String'));
global video;
global img_height;
global img_width;
% 获取视频的总帧数
numFrames = video.NumberOfFrames;
numFrames=num2str(numFrames);
for i = a:1:b
    I = read(video,i);
    axes(handles.axes8)
    imshow(I);%阈值
    title('原图');
    %测试
    Image=I;
    ImageA=Image(:,:,1);
    ImageA=ImageA(100:300,:);
    
    ImageB=Image(:,:,2);
    ImageB=ImageB(100:300,:);
    
    ImageC=Image(:,:,3);
    ImageC=ImageC(100:300,:);
    
    Image=cat(3,ImageA,ImageB,ImageC);
    imwrite(Image,['fz2/',num2str(i),'.jpg']);
    
end
set(handles.edit18,'string','分帧结束');

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit18,'string','检测开始');
pause(0.05)
A=str2num(get(handles.edit15,'String'));
B=str2num(get(handles.edit16,'String'));

for i=A:5:B
    
    Image=imread(strcat('fz2\',num2str(i),'.jpg'));
    
    axes(handles.axes9)
    imshow(Image);%阈值
    title(i);
    
% Define thresholds for channel 1 based on histogram settings
channel1Min = 128.000;
channel1Max = 192.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 26.000;
channel2Max = 57.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 13.000;
channel3Max = 95.000;


% Create mask based on chosen histogram thresholds
I_bw = (Image(:,:,1) >= channel1Min ) & (Image(:,:,1) <= channel1Max) & ...
    (Image(:,:,2) >= channel2Min ) & (Image(:,:,2) <= channel2Max) & ...
    (Image(:,:,3) >= channel3Min ) & (Image(:,:,3) <= channel3Max);
    
    %axes(handles.axes10)
    %imshow(I_bw);%阈值
    %title('分割图');
    se=[1;1;1]; 
    I_bw1=imerode(I_bw,se); %%腐蚀，相当于让线条更细，细到没有
    se=strel('disk',4);       %生成圆形结构元素
    I_bw2=imdilate(I_bw1,se);    
    I_bw3=bwareaopen(I_bw2,500);    
    %axes(handles.axes11)
    %imshow(I_bw3);%阈值
    %title('去除干扰');
    

    STATS = regionprops(I_bw3,'all');%L为二值图
    %在L图像上绘制出连通域的矩形框
    axes(handles.axes9)
    hold on
    
    
    %在L图像上绘制出连通域的矩形框
  
    for kkk = 1 : size(STATS, 1)
        boundary = STATS(kkk).BoundingBox;
        rectangle('Position',boundary,'edgecolor','y' );
        a=boundary(1);
        b=boundary(2);
        c=boundary(3);
        d=boundary(4);
        X=a+0.5*c;
        Y=b+0.5*d;
        plot(X, Y,'b*')

        
        if kkk==1
            global X1;
            global Y1;
            X1=X;
            Y1=Y;
            x1=X1/15;%转换为实际坐标
            y1=Y1/15;
            set(handles.edit1,'string',x1);
            set(handles.edit2,'string',y1);
            centroid1 = [x1,y1]; % 质心坐标，x1和y1是计算出来的质心实际坐标值
            text(X1, Y1-30, sprintf('(%.1f, %.1f)',centroid1), 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心下方显示坐标信息
            %txt = '(x1,y1) \rightarrow';
            %txt = ['(' num2str(center1) ')'];
            %text(X,Y,txt,'Color', 'red', 'FontSize',12,'HorizontalAlignment', 'right')
            
 
        else kkk==2
            global X2;
            global Y2;
            X2=X;
            Y2=Y;
            x2=X2/15;
            y2=Y2/15;
            set(handles.edit3,'string',x2);
            set(handles.edit4,'string',y2);
            centroid2 = [x2,y2]; % 质心坐标，x2和y2是计算出来的质心实际坐标值
            text(X2, Y2+30, sprintf('(%.1f, %.1f)', centroid2), 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心上方显示坐标信息
            %txt = '(x2,y2) \lefttarrow';
            %txt = ['(' num2str(center2) ')'];
            %text(X,Y,txt,'Color', 'red', 'FontSize',12,'HorizontalAlignment', 'left');
           
            plot([X1, X2], [Y1, Y2], 'y-', 'LineWidth', 2); %在两质心之间用黄色的直线连接
        end                
        
    end    

    %判别
    global X1;
    global Y1;
    global X2;
    global Y2;
    a1=str2num(get(handles.edit1,'String'));
    a2=str2num(get(handles.edit2,'String'));
    a3=str2num(get(handles.edit3,'String'));
    a4=str2num(get(handles.edit4,'String'));
    disp('距离');
    ddd=sqrt(     (a1-a3).^2  +  (a2-a4).^2       ); %勾股定理
    txt = ['距离为：',num2str(ddd),'mm'];
    X3=(X1+X2)/2;
    Y3=(Y1+Y2)/2;
    text(X3, Y3-60, txt, 'Color', 'red', 'FontSize', 12,'HorizontalAlignment', 'center');%在质心上方显示坐标信息
    %ddd=ddd/15;%像素和实际距离的关系，大概15个像素点是1mm
    set(handles.edit5,'string',ddd);
    if ddd<5 %小于5mm预警
        set(handles.edit6,'string','靠近注意');
        [filex,fs]=audioread('滴.wav');
        sound(filex,fs);
    else
        set(handles.edit6,'string','安全距离');
    end    
    
    pause(0.01);
end
set(handles.edit18,'string','检测结束');

function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% 退出
close all;


% --- Executes during object deletion, before destroying properties.
function text5_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
