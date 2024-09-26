clc
clear

%% constants

NFFT=16000;     % for FFT Size
fs=8000;
fscal = linspace(0,fs/2,NFFT/2);
M=8;

normWin = 15;                 % Normalization window
buffer = zeros(M, NFFT/2);    % for collecting 'M' chunks

row = 50;
col = 4000;
newLine = zeros(row,col);

numCoeff = 10;
row_cnt = 1;
image_cnt = 1;

DEMON_ALI = zeros(1,400);
Merge_Image = zeros(50,4400);
%%  Checking the size of file in bytes and seconds

path_R = "D:\SHIPS Acoustics Database\DeepShip\MergedFiles\Tug_merged.bin";
sizeFile=dir(path_R);
sizeSecs=floor(sizeFile.bytes/4)/8000

% path_W = "D:\SHIPS Acoustics Database\DeepShip\MergedFiles\Journal2\Tug\Tug_LOFAR.bin";
% fileID_W = fopen(path_W,'wb');

maxVal = 10;
minVal = 0;

%%  Reading File chunk by chunk
fileID_R = fopen(path_R,'rb');
temp1 = zeros(1,fs);
temp2 = zeros(1,fs);

LOFAR = zeros(row,col);

for k=1:sizeSecs
% for k=1:21214
% for k=1:100
        
        % making sliding buffers with 50 percent overlap
        buffer(2:end,:) = buffer(1:end-1,:);


        temp1 = (fread(fileID_R,fs,"float32")).'; % reading new one second of data
        temp = cat(2,temp1,temp2).'; 


        % CAPSE based LOFAR Code
        newData_fft = 2*fft(temp.*hann(NFFT),NFFT);
        buffer(1,:) = (newData_fft(1:NFFT/2));

        for kk =1:NFFT/2
            Caps22fft(:,kk) = fftshift(fft(buffer(:,kk),M));
            Capse_spec_acc(kk) = max(abs(Caps22fft(:,kk)))./M;
        end

        CAPSE = 20*log10(2*abs(Capse_spec_acc));
        CAPSE_spec_norm = CAPSE - medfilt1(CAPSE,normWin);
        CAPSE_spec_Bkground =medfilt1(CAPSE,normWin);

        % Spectral coherence based DEMON
            Nw = 100;               % window length (number of samples)
            alpha_max = 200;       % maximum cyclic frequency to scan (in Hz)
                                    % (should cover the cyclic frequency range of interest)
            opt.coh = 1;            % compute sepctral coherence? (yes=1, no=0)
            
            
            [S,alpha,f,Nv] = Fast_SC(temp,Nw,alpha_max,fs,opt);

            DEMON_ALI(3:400) = mean(abs(S(:,2:end)));

            DEMON_ALI = DEMON_ALI - medfilt1(DEMON_ALI,normWin);
            DEMON_ALI(DEMON_ALI>1) = 1;     % clipping data above given value
            DEMON_ALI(DEMON_ALI<0) = 0;     % clipping data below given value
            DEMON_img = uint8(2000*DEMON_ALI);




            LOFAR_ALI = CAPSE_spec_norm(1:4000);        
            LOFAR_ALI(LOFAR_ALI>maxVal) = maxVal;     % clipping data above given value
            LOFAR_ALI(LOFAR_ALI<minVal) = minVal;     % clipping data below given value
            LOFAR_img = uint8(25*LOFAR_ALI);
            
            MER_LOF_DEM = cat(2,LOFAR_img,DEMON_img);

            Merge_Image(2:50,:) = Merge_Image(1:49,:);
            Merge_Image(1,:) = MER_LOF_DEM;

            if (mod(k,10)==0)
            img = uint8(Merge_Image);
            imwrite(img,"D:\SHIPS Acoustics Database\DeepShip\MergedFiles\DeepShip 48x3072 CAPSE images\test\Tug\" + "Image_" + num2str(image_cnt) +".png");
            image_cnt=image_cnt+1
            end



        % if (row_cnt<= row)
        %     LOFAR(row_cnt,:) = CAPSE_spec_norm(1:col);
        %     row_cnt = row_cnt +1;
        % elseif (row_cnt > row)
        %     % disp('One chunk completed')
        %     % figure(1)
        %     LOFAR(LOFAR>maxVal) = maxVal;     % clipping data above given value
        %     LOFAR(LOFAR<minVal) = minVal;     % clipping data below given value
        % 
        %     img = uint8(25*LOFAR(:,1:col));
        %     imwrite(img,"D:\SHIPS Acoustics Database\DeepShip\MergedFiles\DeepShip 48x3072 CAPSE images\test\" + "Image_" + num2str(image_cnt) +".png");
        %     image_cnt = image_cnt+1;
        %     % figure(1)
        %     % pcolor(LOFAR)
        %     % shading interp
        %     % colormap gray
        %     % pause(1);
        %     LOFAR(:,:) = 0;
        %     row_cnt = 1;
        % 
        % end



        temp2=temp1;


end
% fclose(fileID_W);
fclose(fileID_R);


