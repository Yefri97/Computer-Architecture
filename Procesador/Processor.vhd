library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Processor is
    Port ( rst : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end Processor;

architecture Behavioral of Processor is

	COMPONENT ProgramCounter
	PORT(
		data : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		CLK : IN std_logic;          
		dataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Adder
	PORT(
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);          
		result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT InstructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		dataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RegisterFile
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		DWR : IN std_logic_vector(31 downto 0);
		WREN: IN std_logic;
		rs1Out : OUT std_logic_vector(31 downto 0);
		rs2Out : OUT std_logic_vector(31 downto 0);
		rdOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ControlUnit
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		WREN : OUT std_logic;
		WRENMEM : OUT std_logic;
		SRC : OUT std_logic;
		aluOp : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ArithmeticLogicUnit
	PORT(
		op1 : IN std_logic_vector(31 downto 0);
		op2 : IN std_logic_vector(31 downto 0);
		aluOp : IN std_logic_vector(5 downto 0);
		C : IN  STD_LOGIC;
		result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Multiplexor
	PORT(
		input0 : IN std_logic_vector(31 downto 0);
		input1 : IN std_logic_vector(31 downto 0);
		cond : IN std_logic;          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SignExtender
	PORT(
		input : IN std_logic_vector(12 downto 0);          
		output : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ProcessorStateRegisterModifier
	PORT(
		rst : IN std_logic;
		msb1 : IN std_logic;
		msb2 : IN std_logic;
		result : IN std_logic_vector(31 downto 0);
		aluOp : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ProcessorStateRegister
	PORT(
		NZVC : IN std_logic_vector(3 downto 0);
		nCWP : IN std_logic;          
		C : OUT std_logic;
		CWP : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT DataMemory
	PORT(
		ADDRESS : IN std_logic_vector(4 downto 0);
		CRD : IN std_logic_vector(31 downto 0);
		WRENMEM : IN std_logic;          
		CMEM : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal a, b, c, inst, crs1, crs2, crd, res, roi, imm, dwr, cmem : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
signal carry, cwp, ncwp, wren, wrenmem, src : STD_LOGIC;
signal nzvc : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal op, nrs1, nrs2, nrd : STD_LOGIC_VECTOR (5 downto 0) := "000000";


begin

	nPC: ProgramCounter PORT MAP(
		data => a,
		rst => rst,
		CLK => CLK,
		dataOut => b
	);
	
	PC: ProgramCounter PORT MAP(
		data => b,
		rst => rst,
		CLK => CLK,
		dataOut => c
	);

	ADD: Adder PORT MAP(
		op1 => "00000000000000000000000000000001",
		op2 => b,
		result => a
	);

	IM: InstructionMemory PORT MAP(
		address => c,
		rst => rst,
		dataOut => inst
	);
	
	RF: RegisterFile PORT MAP(
		rs1 => nrs1,
		rs2 => nrs2,
		rd => nrd,
		rst => rst,
		DWR => dwr,
		WREN => wren,
		rs1Out => crs1,
		rs2Out => crs2,
		rdOut => crd
	);
	
	CU: ControlUnit PORT MAP(
		op => inst(31 downto 30),
		op3 => inst(24 downto 19),
		WREN => wren,
		WRENMEM => wrenmem,
		SRC => src,
		aluOp => op
	);
	
	ALU: ArithmeticLogicUnit PORT MAP(
		op1 => crs1,
		op2 => roi,
		aluOp => op,
		C => carry,
		result => res
	);
	
	MUX0: Multiplexor PORT MAP(
		input0 => crs2,
		input1 => imm,
		cond => inst(13),
		output => roi
	);

	SEU: SignExtender PORT MAP(
		input => inst(12 downto 0),
		output => imm
	);
	
	PSRModifier: ProcessorStateRegisterModifier PORT MAP(
		rst => rst,
		msb1 => crs1(31),
		msb2 => roi(31),
		result => res,
		aluOp => op,
		nzvc => nzvc
	);
	
	PSR: ProcessorStateRegister PORT MAP(
		NZVC => nzvc,
		nCWP => ncwp,
		C => carry,
		CWP => cwp
	);

	WM: WindowsManager PORT MAP(
		rs1 => inst(18 downto 14),
		rs2 => inst(4 downto 0),
		rd => inst(29 downto 25),
		op => inst(31 downto 30),
		op3 => inst(24 downto 19),
		cwp => cwp,
		nrs1 => nrs1,
		nrs2 => nrs2,
		nrd => nrd,
		ncwp => ncwp
	);
	
	DM: DataMemory PORT MAP(
		ADDRESS => res(4 downto 0),
		CRD => crd,
		WRENMEM => wrenmem,
		CMEM => cmem
	);
	
	MUX1: Multiplexor PORT MAP(
		input0 => cmem,
		input1 => res,
		cond => src,
		output => dwr
	);
	
	result <= dwr;
	
end Behavioral;