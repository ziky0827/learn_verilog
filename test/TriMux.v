//��ѡһ��·ѡ����,�ŵ�·����ʱ��״̬���ָ���̬
`timescale 1ns/100ps
module TriMux(i0,i1,sele,y);
	input i0,i1,sele;
	output y;
	wire sele_;
		not #5 g0(sele_,sele);
		bufif1 #4
		g1(y,i0,sele_),
		g2(y,i1,sele);
endmodule
