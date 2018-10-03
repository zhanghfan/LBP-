X = imread('1.bmp');                    %读取图片

X = double(X);                           %转换成double类型，后面才能参与运算

extend = zeros(114,94);                %扩展一圈的全零矩阵

extend(2:113,2:93) = X;                  %把X放到extend中间

 

extend(1,2:93) = X(1,1:92);             %向上扩展，复制原图第一行

extend(114,2:93) = X(112,1:92);         %向下扩展，复制原图最后一行

extend(2:113,1) = X(1:112,1);           %向左扩展，复制原图第一列

extend(2:113,94) = X(1:112,92);         %向右扩展，复制原图最后一列

 

B2D = [1 2 4;128 0 8;64 32 16];         %二进制→十进制转换模板备用

 

Result = zeros(112,92);

for i = 1:112

    for j = 1:92

        temp =  X(i,j);                  %取原图某点的像素值，即中心阈值temp

        A = ones(3)*temp;               %3*3矩阵，元素全为temp

        B =extend(i:(i+2),j:(j+2));     %从扩展图像中取出3*3邻域矩阵

        C = B - A;                       %两矩阵相减比大小

        C(find(C>=0)) = 1;               %判断C中非负数，置为1

        C(find(C<0)) = 0;                %判断C中负数，置为0

        Result(i,j) =sum(sum(C.*B2D));  %点乘求和，返回Result作为LBP值

        %sum(矩阵) = 按列求和，得行向量

        %sum(行向量) = 各项求和，得一个实数

        %sum(sum(矩阵)) = 先按列，再各项，即矩阵全部元素求和

    end

end

 

figure;

%开个图形窗口

subplot(1,2,1),imshow(mat2gray(X)); title('Gray');  

%窗口中，左图显示原始图像

subplot(1,2,2),imshow(mat2gray(Result)); title('LBP');

%窗口中，右图显示LBP纹理图像