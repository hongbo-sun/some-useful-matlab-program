%ɫ�ʷ��� ��ɫռ��
close all
clear
clc

Img = imread('./baozha2.jpg');

Image = Img;



[M,N,O] = size(Image);
[h,s,v] = rgb2hsv(Image);

H = h; S = s; V = v;
h = h*360;
%��hsv�ռ�ǵȼ��������
%? h������16����
%? s������4����
%? v������4����
for i = 1:M
    for j = 1:N
        if h(i,j)<=15||h(i,j)>345
            H(i,j) = 0;
        end
        if h(i,j)<=25&&h(i,j)>15
            H(i,j) = 1;
        end
        if h(i,j)<=45&&h(i,j)>25
            H(i,j) = 2;
        end
        if h(i,j)<=55&&h(i,j)>45
            H(i,j) = 3;
        end
        if h(i,j)<=80&&h(i,j)>55
            H(i,j) = 4;
        end
        if h(i,j)<=108&&h(i,j)>80
            H(i,j) = 5;
        end
        if h(i,j)<=140&&h(i,j)>108
            H(i,j) = 6;
        end
        if h(i,j)<=165&&h(i,j)>140
            H(i,j) = 7;
        end
        if h(i,j)<=190&&h(i,j)>165
            H(i,j) = 8;
        end
        if h(i,j)<=220&&h(i,j)>190
            H(i,j) = 9;
        end
        if h(i,j)<=255&&h(i,j)>220
            H(i,j) = 10;
        end
        if h(i,j)<=275&&h(i,j)>255
            H(i,j) = 11;
        end
        if h(i,j)<=290&&h(i,j)>275
            H(i,j) = 12;
        end
        if h(i,j)<=316&&h(i,j)>290
            H(i,j) = 13;
        end
        if h(i,j)<=330&&h(i,j)>316
            H(i,j) = 14;
        end
        if h(i,j)<=345&&h(i,j)>330
            H(i,j) = 15;
        end
    end
end

for i = 1:M
    for j = 1:N
        if s(i,j)<=0.15&&s(i,j)>0
            S(i,j) = 1;
        end
        if s(i,j)<=0.4&&s(i,j)>0.15
            S(i,j) = 2;
        end
        if s(i,j)<=0.75&&s(i,j)>0.4
            S(i,j) = 3;
        end
        if s(i,j)<=1&&s(i,j)>0.75
            S(i,j) = 4;
        end
    end
end

for i = 1:M
    for j = 1:N
        if v(i,j)<=0.15&&v(i,j)>0
            V(i,j) = 1;
        end
        if v(i,j)<=0.4&&v(i,j)>0.15
            V(i,j) = 2;
        end
        if v(i,j)<=0.75&&v(i,j)>0.4
            V(i,j) = 3;
        end
        if v(i,j)<=1&&v(i,j)>0.75
            V(i,j) = 4;
        end
    end
end

hm=M;
hn=N;
G=zeros(hm,hn);    % ���ÿһ�����ص���ɫ�ȼ�����
for i=1:hm
    for j=1:hn
        G(i,j)=H(i,j)*16+S(i,j)*4+V(i,j);
    end
end








% ����4*16��ά������H-S����
Hist = zeros(16,4);
for i = 1:M
    for j = 1:N
        for k = 1:16
            for l = 1:4
                if  l==S(i,j)&& k==H(i,j)+1
                    Hist(k,l) = Hist(k,l)+1;
                end
            end
        end
    end
end
for k = 1:16
    for l =1:4
        His((k-1)*4+l) = Hist(k,l);%ת��Ϊһά����
    end
end



His = His/max(His);

% �ֹ����Ʋ�ɫͼ��ֱ��ͼ
% hist_h
num_len=200;

m=0;
for j = 1:256
    if rem(j,16)==1 && m<16
        for k = 0:15
            for i = 1:num_len
                hist_h(i,j+k) = m;
            end
        end
        m = m+1;
    end
end
% hist_s
m=0;
for j = 1:256
    if rem(j,4) == 1 && m<64
        n = rem(m,4);
        for k = 0:3
            for i =1:num_len
                hist_s(i,j+k) = n+1 ;
            end
        end
        m = m+1;
    end
end
% hist_v
for j = 1:256
    for i = 1:num_len
        hist_v(i,j) = 1;
    end
end
% ��His��ֵ��hist_v
for k = 0:63
    for j = 1:256
        if floor((j-1)/4) == k
            for i = 1:num_len
                if i<=200-His(k+1)*200
                    hist_v(i,j) = 0;
                end
            end
        end
    end
end

%��h��s��v����ͼ�ϲ�ת��ΪRGBģʽ
I_H = hsv2rgb(hist_h/16,hist_s/4,hist_v);
I=I_H(:,4:end,:);
% ��ͼ��ʾ?

imshow(I_H);
imwrite(I,'./color_hist.jpg');

