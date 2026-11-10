package enum_defines_pkg;


typedef enum logic  [3:0] {
    ALU_NOP=0,
    ALU_ADD=1,
    // new for phase 6
    ALU_AND=2, 
    ALU_OR=3, 
    ALU_XOR=4, 
    ALU_SUB=5, 
    ALU_SLT=6, 
    ALU_SRL=7, 
    ALU_SRA=8, 
    ALU_SLL=9, 
    ALU_SLTU=10
} alu_op_t;


typedef enum logic  [1:0] {
    ALU1_REG=0,
    ALU1_ZERO=1,
    ALU1_PC=2
} alu_src1_sel_t;


typedef enum logic  [0:0] {
    ALU2_REG=0,
    ALU2_IMM=1
} alu_src2_sel_t;



typedef enum logic  [1:0] {
    FWD_IDEX=2'b00,
    FWD_MEWB=2'b01,
    FWD_EXME=2'b10
} alu_fwd_sel_t;

typedef enum logic {
    BRADDR_ALU=0,
    BRADDR_ADDR=1
} branch_sel_t;


typedef enum logic[1:0] {
    RFWT_ALU=0,
    RFWT_PC=1,
    RFWT_LD=2
} rfwt_sel_t;

typedef enum logic[1:0] {
    BRANCHOP_FALSE=0,
    BRANCHOP_TRUE=1,
    BRANCHOP_COND_FALSE=2,
    BRANCHOP_COND_TRUE=3
} branch_op_t;

typedef enum logic {
    PC_PC4=0,
    PC_TARGET=1
} pc_src_t;

typedef enum logic  [1:0] {
    LDOP_NOT=0,
    LDOP_SIGNED=1,
    LDOP_UNSIGNED=2
} ldop_t;


endpackage : enum_defines_pkg   