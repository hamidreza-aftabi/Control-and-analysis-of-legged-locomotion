#ifndef __c2_stance2_h__
#define __c2_stance2_h__

/* Include files */
#include "sf_runtime/sfc_sf.h"
#include "sf_runtime/sfc_mex.h"
#include "rtwtypes.h"
#include "multiword_types.h"

/* Type Definitions */
#ifndef typedef_SFc2_stance2InstanceStruct
#define typedef_SFc2_stance2InstanceStruct

typedef struct {
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint32_T chartNumber;
  uint32_T instanceNumber;
  int32_T c2_sfEvent;
  boolean_T c2_isStable;
  boolean_T c2_doneDoubleBufferReInit;
  uint8_T c2_is_active_c2_stance2;
  real_T *c2_G;
  real_T *c2_stm;
  real_T *c2_stm0;
  real_T *c2_t;
  real_T *c2_dp;
  real_T *c2_Fmtc;
  real_T *c2_Fmtcdelay;
} SFc2_stance2InstanceStruct;

#endif                                 /*typedef_SFc2_stance2InstanceStruct*/

/* Named Constants */

/* Variable Declarations */
extern struct SfDebugInstanceStruct *sfGlobalDebugInstanceStruct;

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c2_stance2_get_eml_resolved_functions_info(void);

/* Function Definitions */
extern void sf_c2_stance2_get_check_sum(mxArray *plhs[]);
extern void c2_stance2_method_dispatcher(SimStruct *S, int_T method, void *data);

#endif
