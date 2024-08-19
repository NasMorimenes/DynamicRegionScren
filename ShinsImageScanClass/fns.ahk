ScanImage( xBits ) {
    static x86 :=
    (
        "VVdWU4PsHItEJDSLTCQwi3wkOIt0JDyLEItZCIlEJAyJfCQEi3wkQInViXQkCMHtEDnrD4bHAAAAi3EMD7fSOfIPg7kAAACLQQQp1g"
        "+2VCQEKeuJUBAPvlQkCMcAAAAAAMdABAAAAACJWAiJcAyJUBSF/3Q7g/8BdE6D/wJ0WYP/A3Q8g/8EdGeD/wV0aoP/BnRVg/8HdXWL"
        "RCQMiUwkMIlEJDSLQUDrCo20JgAAAACLQTCDxBxbXl9d/+CNdCYAi0E86+6NdgCLQTiDxBxbXl9d/+CNdCYAi0E0g8QcW15fXf/gjX"
        "QmAItBROvGjXYAi0FM676NdgCLQUjrto12ALj+////g8QcW15fXcO4/////+vxkJCQkJCQkJCQkJCQ"
    )
    static x64 :=
    (
        "V1ZTiwJEi1kQi3QkQInHwe8QQTn7D4bVAAAAi1kUD7fAOdgPg8cAAABMi1EIQSn7KcNFD7bARQ++yUnHAgAAAABFiVoIQYlaDEWJQhB"
        "FiUoUhfZ0M4P+AXRGg/4CdFGD/gN0NIP+BHRng/4FdHKD/gZ0TYP+Bw+FfQAAAEiLQXjrCmYPH0QAAEiLQVhbXl9I/+BmDx9EAABIi0"
        "Fw6+5mkEiLQWhbXl9I/+BmDx9EAABIi0FgW15fSP/gZg8fRAAASIuBgAAAAOvDDx+AAAAAAEiLgZAAAADrsw8fgAAAAABIi4GIAAAA6"
        "6MPH4AAAAAAuP7///9bXl/DuP/////r9Q=="
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanImageArray( xBits ) {
    static x86 :=
    (
        "VVdWU4PsHItEJDSLTCQwi3wkOIt0JDyLEItZCIlEJAyJfCQEi3wkQInViXQkCMHtEDnrD4bHAAAAi3EMD7fSOfIPg7kAAACLQQQp1g"
        "+2VCQEKeuJUBAPvlQkCMcAAAAAAMdABAAAAACJWAiJcAyJUBSF/3Q7g/8BdE6D/wJ0WYP/A3Q8g/8EdGeD/wV0aoP/BnRVg/8HdXWL"
        "RCQMiUwkMIlEJDSLQUDrCo20JgAAAACLQTCDxBxbXl9d/+CNdCYAi0E86+6NdgCLQTiDxBxbXl9d/+CNdCYAi0E0g8QcW15fXf/gjX"
        "QmAItBROvGjXYAi0FM676NdgCLQUjrto12ALj+////g8QcW15fXcO4/////+vxkJCQkJCQkJCQkJCQ"
    )
    static x64 :=
    (
        "V1ZTiwJEi1kQi3QkQInHwe8QQTn7D4bVAAAAi1kUD7fAOdgPg8cAAABMi1EIQSn7KcNFD7bARQ++yUnHAgAAAABFiVoIQYlaDEWJQhB"
        "FiUoUhfZ0M4P+AXRGg/4CdFGD/gN0NIP+BHRng/4FdHKD/gZ0TYP+Bw+FfQAAAEiLQXjrCmYPH0QAAEiLQVhbXl9I/+BmDx9EAABIi0"
        "Fw6+5mkEiLQWhbXl9I/+BmDx9EAABIi0FgW15fSP/gZg8fRAAASIuBgAAAAOvDDx+AAAAAAEiLgZAAAADrsw8fgAAAAABIi4GIAAAA6"
        "6MPH4AAAAAAuP7///9bXl/DuP/////r9Q=="
    )    

    if ( xBits == 64 ) {
		return x64
    }
    
	return x86
}

ScanImageArrayRegion( xBits ) {
    static x86 := 
    (
        "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"
    )
    static x64 := 
    (
        "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"
        "+mu+///kJCQkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}


ScanImageCount( xBits ) {
    static x86 :=
    (
        "VVdWU4PsPIt8JFSLRCRUi1QkWIt3BIsAi3wkUInFiXQkJIt/CMHtEIl8JBg57w+G/AQAAA+32ItEJFCJXCQMi0AMOcMPg+YEAAAp7ynY"
        "iXwkKIlEJDCE0g+EbAEAAItEJCSFwA+EYwIAAItEJDCFwA+OrQQAAI0ErQAAAADHRCQsAAAAAIlEJByLRCQYx0QkNAAAAADB4ALHRCQk"
        "AAAAAIlEJBQPtsKJbCQEicWLRCQohcAPjuoAAADHRCQgAAAAAI20JgAAAACLfCQMhf8PhKwAAACLRCQgA0QkLMdEJBAAAAAAweACi3wk"
        "VIlEJAiQi3QkBIX2dGkxyY22AAAAAItcjwiB+/////52TIt0JFCNBI0AAAAAAwaLdCQIiwQwid7B/hCJwsH6EA+20okUJInyD7byixQk"
        "KfKJ1sH+HzHyKfI56n9JD7bED7bfKdiZMdAp0DnFfDiDwQE5TCQEdZ+DRCQQAYtMJBSLRCQQAUwkCAN8JBw5RCQMD4Vw////i3wkBINE"
        "JCQBAXwkII12AINEJCABi0QkIDlEJCgPjyX///+DRCQ0AYtcJBiLRCQ0AVwkLDlEJDAPhe/+//+LRCQkg8Q8W15fXcOF9g+EbwIAAIXA"
        "D45JAwAAx0QkEAAAAADHRCQkAAAAAIksJItsJFCLXCQohdsPjrEAAADHRCQIAAAAAOsxifaNvCcAAAAAi00AjRwGgeL///8AiwyZgeH/"
        "///AOcp0U4NEJAgBi0QkCDlEJCh+dotMJAyFyXRTx0QkBAAAAACLBCSFwHQ1i1wkBIt8JFSLdCQQD6/DAd4Pr3QkGAN0JAiNPIcxwGaQ"
        "i1SHCIH6/////neUg8ABOQQkdeyDRCQEAYt8JAQ5fCQMf7WLPCSDRCQkAQF8JAiDRCQIAYtEJAg5RCQof4qDRCQQAYtEJBA5RCQwD4Uw"
        "////i0QkJIPEPFteX13Di1wkMIXbD47l/v//jQStAAAAAMdEJDgAAAAAiUQkIItEJBjHRCQ0AAAAAMHgAsdEJCwAAAAAiUQkHA+2wols"
        "JAiJxYtMJCiFyQ+OswAAAMdEJCQAAAAAjXQmAItUJAyF0g+E6wAAAItEJCQDRCQsx0QkEAAAAADB4AKLfCRUiUQkFJCLRCQIhcAPhKQA"
        "AACLXCRQi0QkFDHJAwOJRCQE6xxmkA+2xA+23ynYmTHQKdA56H87g8EBOUwkCHR2i0QkBItcjwiLBIiJ3sH+EInCwfoQD7bSiRQkifIP"
        "tvKLFCQp8onWwf4fMfIp8jnqfrSDRCQkAYtEJCQ5RCQoD49Z////g0QkOAGLXCQYi0QkOAFcJCw5RCQwD4Um////i0QkNIlEJCSLRCQk"
        "g8Q8W15fXcNmkINEJBABi0wkHItEJBABTCQUA3wkIDlEJAwPhTH///+LfCQIg0QkNAEBfCQkg0QkJAGLRCQkOUQkKA+P6f7//+uOi1Qk"
        "MIXSD45x/f//x0QkBAAAAADHRCQIAAAAAItEJCiFwA+OkwAAAMcEJAAAAADrE422AAAAAIMEJAGLBCQ5RCQofneLRCQMhcB0WjH/he10"
        "S4tcJFCLRCQEixMB+A+vRCQYAwQki1wkVI00gonoD6/HjRyDMcCQjbQmAAAAAIsMhotUgwiB4f///wCB4v///wA50XWhg8ABOcV14oPH"
        "ATl8JAx/qAEsJINEJAgBgwQkAYsEJDlEJCh/iYNEJAQBi0QkBDlEJDAPhU7///+LRCQIiUQkJItEJCSDxDxbXl9dw8dEJCQAAAAA6Y78"
        "///HRCQk/v///+mB/P//kJCQ"
    )
    static x64 :=
    (
        "QVdBVkFVQVRVV1ZTSIPsKESLaRBFiexJideLEkSJLCRIictBi3cERQ+2yInVwe0QiXQkDEE57Q+GmwQAAEQPt/KLURRBOdYPg4sEAACJ"
        "10Ep7UQp90SJbCQIiXwkFEWEwA+ESwEAAESLVCQMRYXSD4QrAgAARItEJBRFhcAPjkgEAADHRCQQAAAAAI11/0UPttHHRCQYAAAAAMdE"
        "JAwAAAAAi0wkCIXJD47VAAAAx0QkBAAAAABmLg8fhAAAAAAARYX2D4SXAAAAi3wkBEUx5AN8JBBFMe1mDx+EAAAAAACF7XRpSWPERTHA"
        "TY0ch+sDSYnAQ4tMgwiB+f////52REiLE0KNBAdBiclBwfkQiwSCRQ+2yYnCwfoQD7bSRCnKQYnRQcH5H0QxykQpykQ50n8+D7bED7bN"
        "KciZMdAp0EE5wnwsSY1AAUw5xnWjQYPFAUEB7AM8JEU57g+FgP///4NEJAwBAWwkBA8fgAAAAACDRCQEAYtEJAQ5RCQID489////g0Qk"
        "GAGLDCSLRCQYAUwkEDlEJBQPhQX///+LRCQMSIPEKFteX11BXEFdQV5BX8OF9g+ERwIAAIX/D44JAwAAx0QkDAAAAAAx/0WF7Q+OuQAA"
        "AEUx2+suZg8fRAAATIsTQYnQJf///wBHiwSCQYHg////AEQ5wHRWQYPDAUU53Q+OhgAAAEKNdB0ARYX2dGdFMdJCjXQdAGYPH0QAAIXt"
        "dEyJ6EaNDBdEiRQkQQ+vwkUPr8xImEONFAtJjUyHCEEB8Q8fQACLAT3////+d4+DwgFIg8EEQTnRdetEixQkQYPCAesNZg8fhAAAAAAA"
        "QYPCAUU51n+nQYnzg0QkDAFBg8MBRTndD496////g8cBOXwkFA+FMf///+n9/v//i1QkFIXSD47x/v//x0QkGAAAAADHRCQQAAAAAMdE"
        "JBwAAAAAi0QkCIXAD47QAAAAi0QkHMdEJAQAAAAASIlcJHAB6IlEJAxmDx+EAAAAAABFhfYPhOoAAACLdCQMRTHtA3QkBEUx5GYPH4QA"
        "AAAAAIXtD4S4AAAASItEJHCJ8inqTIsASWPESY1MhwjrJ2aQD7bED7bfKdhBicJBwfofRDHQRCnQRDnIfz6DwgFIg8EEOdZ0e4nQixlB"
        "iwSAQYnbQYnCQcH7EEHB+hBFD7bbRQ+20kUp2kWJ00HB+x9FMdpFKdpFOcp+qINEJAQBi0QkBDlEJAgPj1X///9Ii1wkcINEJBgBizQk"
        "i0QkGAF0JBw5RCQUD4UK////i0QkEIlEJAzp1v3//2YPH4QAAAAAAEGDxQEDNCRBAexFOe4PhS3///8BbCQEg0QkEAGDRCQEAYtEJAQ5"
        "RCQID4/x/v//65qLdCQUhfYPjpD9//9FMe1FMeREiWwkBESLLCREi1wkCEWF2w+OgwAAADH26wtmkIPGATl0JAh+dI18NQBFhfZ0W0Ux"
        "2418NQCF7XRHiehHjQwcTIsTQQ+vw0UPr81ImEKNDA5NjUSHCEEB+Q8fQACJyEGLFIJBiwCB4v///wAl////ADnCdaiDwQFJg8AEQTnJ"
        "ddxBg8MBRTnef6yJ/oNEJAQBg8YBOXQkCH+MQYPEAUQ5ZCQUD4Vg////RItsJAREiWwkDOnS/P//x0QkDAAAAADpxfz//8dEJAz+////"
        "6bj8//+QkJCQkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanImageCountRegion( xBits ) {
    static x86 :=
    (
        "VVdWU4PsOIt8JGSLVCRci0wkVIt0JGCJ+IgEJAHRhdJ5DItEJFT32olMJFSJwYtcJFgB84X2eQyLRCRY996JXCRYicOLRCRUhcAPiFoF"
        "AACLRCRYhcAPiE4FAACLRCRQi2wkUIsAi20EiWwkKInFwe0QOeoPjCMFAAAPt8CJRCQMOcYPjBQFAACLdCRMi3YIiXQkGDnuD4L0BAAA"
        "i1QkTItSDDnCD4LlBAAAKekpw41G/znOD0fBOdqJRCQkjUL/D0fDiUQkMInDifiEwA+EZwEAAIt8JCiF/w+EXgIAADlcJFgPjZoEAACL"
        "fCRYifDHRCQoAAAAAMHgAolsJAQPr/6JRCQUD7YEJIl8JCyNPK0AAAAAicWJfCQci0QkJDlEJFQPjesAAACLRCRUiUQkIItcJAyF2w+E"
        "tAAAAItEJCADRCQsx0QkEAAAAADB4AKLfCRQiUQkCIn2jbwnAAAAAItMJASFyXRpMcmNtgAAAACLXI8Igfv////+dkyLdCRMjQSNAAAA"
        "AAMGi3QkCIsEMInewf4QicLB+hAPttKJFCSJ8g+28osUJCnyidbB/h8x8inyOep/SQ+2xA+23ynYmTHQKdA5xXw4g8EBOUwkBHWfg0Qk"
        "EAGLTCQUi0QkEAFMJAgDfCQcOUQkDA+FcP///4t8JASDRCQoAQF8JCCNdgCDRCQgAYtEJCA5RCQkD48d////i3wkGINEJFgBAXwkLItE"
        "JDA7RCRYD4Xs/v//i0QkKIPEOFteX13Di0QkKIXAD4RrAgAAOVwkWMdEJCgAAAAAfdqJLCSLbCRMi0QkJDlEJFQPjbUAAACLRCRUiUQk"
        "COstkI10JgCLTQCNHAaB4v///wCLDJmB4f///wA5ynRbg0QkCAGLRCQIOUQkJH5+i0QkDIXAdFvHRCQEAAAAAIsEJIXAdD2LXCQEi3wk"
        "UIt0JBgPr8MDXCRYD6/zA3QkCI08hzHAjXYAjbwnAAAAAItUhwiB+v////53jIPAATkEJHXsg0QkBAGLfCQEOXwkDH+tizwkg0QkKAEB"
        "fCQIg0QkCAGLRCQIOUQkJH+Cg0QkWAGLRCQwO0QkWA+FKv///4tEJCiDxDhbXl9dwzlcJFgPjef+//+LfCRYifDHRCQ0AAAAAMHgAols"
        "JAgPr/6JRCQcD7YEJIl8JCyNPK0AAAAAicWJfCQgi0QkJDlEJFQPjbkAAACLRCRUiUQkKGaQi1QkDIXSD4TzAAAAi0QkKANEJCzHRCQQ"
        "AAAAAMHgAot8JFCJRCQUifaNvCcAAAAAi0QkCIXAD4SkAAAAi1wkTItEJBQxyQMDiUQkBOscZpAPtsQPtt8p2Jkx0CnQOeh/O4PBATlM"
        "JAh0dotEJASLXI8IiwSIid7B/hCJwsH6EA+20okUJInyD7byixQkKfKJ1sH+HzHyKfI56n60g0QkKAGLRCQoOUQkJA+PUf///4t8JBiD"
        "RCRYAQF8JCyLRCQwO0QkWA+FHv///4tEJDSJRCQoi0QkKIPEOFteX13DZpCDRCQQAYtMJByLRCQQAUwkFAN8JCA5RCQMD4Ux////i3wk"
        "CINEJDQBAXwkKINEJCgBi0QkKDlEJCQPj+H+///rjjlcJFgPjXP9///HRCQEAAAAAItEJCQ5RCRUD42LAAAAi0QkVIkEJOsTjbYAAAAA"
        "gwQkAYsEJDlEJCR+b4tEJAyFwHRSMf+F7XRDi1wkTItEJFiLEwH4D69EJBgDBCSLXCRQjTSCiegPr8eNHIMxwIsMhotUgwiB4f///wCB"
        "4v///wA50XWpg8ABOcV14oPHATl8JAx/sAEsJINEJAQBgwQkAYsEJDlEJCR/kYNEJFgBi0QkMDtEJFgPhVT///+LRCQEiUQkKItEJCiD"
        "xDhbXl9dw8dEJCgAAAAA6Z78///HRCQo/v///+mR/P//x0QkKPz////phPz//8dEJCj9////6Xf8//+QkJCQkJCQkJCQ"
    )
    static x64 :=
    (
        "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"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanImageRegion( xBits ) {
    static x86 :=
    (
        "VVdWU4PsLItEJESLfCRYi0wkXItcJECLbCRIi1QkVIlEJBCLRCRMiXwkGIt8JGCJTCQciUQkCItEJFCJfCQMhcB5BAHF99iF0nkGAVQk"
        "CPfahe0PiNcBAACLTCQIhckPiMsBAACLTCQQiwmJz8HvEDn4D4yYAQAAD7fJOcoPjI0BAACLcwiJdCQUif45fCQUD4KKAQAAi3sMOc8P"
        "gn8BAAAB6ANUJAgp8It0JBQpyonxg+kBOcaLdCQID0LBOdeNT/8PQtGLSwSJcQQx9oXAD0jGhdKJKQ9I1olBCA+2RCQYiVEMiUEQD75E"
        "JByJQRSLRCQMhcB0YYN8JAwBD4SGAAAAg3wkDAIPhJMAAACDfCQMA3Rcg3wkDAQPhLkAAACDfCQMBQ+ExgAAAIN8JAwGD4SLAAAAg3wk"
        "DAcPhfcAAACLRCQQiVwkQIlEJESLQ3DrFo20JgAAAACLTCQQiVwkQIlMJESLQ1CDxCxbXl9d/+CLRCQQiVwkQIlEJESLQ2jr5o20JgAA"
        "AACLRCQQiVwkQIlEJESLQ2CDxCxbXl9d/+CLRCQQiVwkQIlEJESLQ1iDxCxbXl9d/+CQjbQmAAAAAItEJBCJXCRAiUQkRItDeOuWjbQm"
        "AAAAAItEJBCJXCRAiUQkRIuDiAAAAOl4////kItEJBCJXCRAiUQkRIuDgAAAAOlg////ifaNvCcAAAAAuPz///+DxCxbXl9dw412ALj+"
        "////6+6J9o28JwAAAAC4/f///+veuP/////r15CQ"
    )
    static x64 :=
    (
        "QVVBVFVXVlOLRCRYRItUJGCLXCRoRItcJHCLdCR4hcB5BUEBwPfYRYXSeQZFAdFB99pFhcAPiFUBAABFhckPiEwBAABEiyJFieVBwe0Q"
        "RDnoD4wZAQAARQ+35EU54g+MDAEAAIt5EEQ57w+CEAEAAItpFEQ55Q+CBAEAAEQBwEUByg+220UPvttEKehFKeJEjWf/OceNff9BD0LE"
        "RDnVRA9C10iLeQhEiQdFMcCFwEEPSMBFhdJEiU8ERQ9I0IlfEIlHCESJVwxEiV8UhfZ0MIP+AXRLg/4CdFaD/gN0MYP+BHRsg/4FdHeD"
        "/gZ0UoP+Bw+FoAAAAEiLQXjrBw8fAEiLQVhbXl9dQVxBXUj/4JBIi0Fw6+5mLg8fhAAAAAAASItBaFteX11BXEFdSP/gkEiLQWBbXl9d"
        "QVxBXUj/4JBIi4GAAAAA67sPH4AAAAAASIuBkAAAAOurDx+AAAAAAEiLgYgAAADrmw8fgAAAAAC4/P///1teX11BXEFdw2aQuP7////r"
        "7mYPH4QAAAAAALj9////6964/////+vXkJA="
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixel( xBits ) {
    static x86 :=
    (
        "V1ZTi1QkEItMJBiLXCQci3IMi0IEi3oID7bJiXAMi3QkFMcAAAAAAMdABAAAAACJeAiJcBCJSBSF23UMW4tCEF5f/+CNdCYAg/sBdDOD"
        "+wJ0PoP7A3Qhg/sEdFSD+wV0X4P7BnQ6g/sHdV1bi0IgXl//4JCNdCYAW4tCHF5f/+Bbi0IYXl//4JCNtCYAAAAAW4tCFF5f/+CQjbQm"
        "AAAAAFuLQiReX//gkI20JgAAAABbi0IsXl//4JCNtCYAAAAAW4tCKF5f/+BbuP////9eX8OQkJCQkJCQkJCQkJCQkJA="
    )
    static x64 :=
    (
        "TItREEiLQQhIxwAAAAAATIlQCEUPtsCJUBBEiUAURYXJdQ1I/2EYZg8fhAAAAAAAQYP5AXQyQYP5AnQ0QYP5A3QeQYP5BHQ4QYP5BXQ6"
        "QYP5BnQkQYP5B3UySP9hOGaQSP9hMA8fQABI/2EoDx9AAEj/YSAPH0AASP9hQA8fQABI/2FQDx9AAEj/YUi4/////8OQkJCQkJCQkJCQ"
        "kJCQkA=="
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelCount( xBits ) {
    static x86 :=
    (
        "VVdWU4PsJIt0JDiLRCRAi0wkPIteCIt2DIgEJIlcJBCJdCQYhMAPhOQAAACF9g+OTAEAAInIx0QkHAAAAAAx9sH4EMdEJBQAAAAAD7bA"
        "iUQkBA+2xYlEJAiNBJ0AAAAAiUQkIA+2wYlEJAyQjXQmAItMJBCFyX5ui0QkOItcJByLTCQgiwCNFJ0AAAAAjSwIjRwQAdWNdgCLEw+2"
        "zitMJAiJ0A+20onPwfgQwf8fD7bAK0QkBDH5KfmJx8H/HzH4Kfg4yA9HyCtUJAyJ18H/HzH6Kfo40Q9D0TgUJIPe/4PDBDnddbKDRCQU"
        "AYtMJBCLRCQUAUwkHDlEJBgPhW////+DxCSJ8FteX13DkI10JgCLVCQYhdJ+aInYMe0x/zH2weACiQQkjXYAjbwnAAAAAItEJBCFwH4x"
        "i0QkOI0crQAAAACLEI0EGgMUJAHTjXYAixCB4v///wA50Q+UwoPABA+20gHWOcN154PHAQNsJBA5fCQYdbqDxCSJ8FteX13Dg8QkMfZb"
        "ifBeX13DkJCQkA=="
    )
    static x64 :=
    (
        "QVdBVkFVQVRVV1ZTSIPsGItBFESLcRCJRCQMSYnNRInFRYTAD4S+AAAAhcAPjgoBAACJ1w+2xkSJ80Ux/8H/EEGJxEUx0g+2ykAPtv8P"
        "HwBFhfZ+bEGJ2UmLdQBFKfGQRInIixSGD7bGRCngQYnAQcH4H0QxwEQpwEGJwInQD7bSwfgQD7bAKfhBicNBwfsfRDHYRCnYRDjAQQ9G"
        "wCnKQYnQQcH4H0QxwkQpwjjQD0LCQDjFQYPa/0GDwQFEOct1n0GDxwFEAfNEOXwkDHWBRInQSIPEGFteX11BXEFdQV5BX8MPH0QAAEGJ"
        "w4XAfk1FifEx20Ux0mYPH4QAAAAAAEWF9n4qRInITYtFAEQp8JCJwUGLDIiB4f///wA5yg+UwYPAAQ+2yUEBykQ5yHXhg8MBRQHxQTnb"
        "dcbrk0Ux0uuOkJCQkJCQkJCQkJCQkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelCountRadius( xBits ) {
    static x86 :=
    (
        "VVdWMfZTg+xci5QkgAAAAItcJHwPtoQkhAAAAItsJHjB6h8DlCSAAAAAi3wkcNH6iEQkGItMJHQB0wHVidiLXCR4KdMPSN6JXCQ4i1wk"
        "fCnTi1cID0nzjVr/OeqLVwwPRus5wo1a/w9Gw4C8JIQAAAAAD4T4AAAAicrB6hAPttqJXCQgD7bdiVwkJA+22YlcJCg5xg+NDgIAAInD"
        "D7ZEJBgrdCR8x0QkNAAAAAArXCR8iXQkMIlcJEiJRCQsiWwkGI20JgAAAACLXCQ4i0QkGDnDfXuLTCQwi2wkfInIAc0Pr8GJRCQ8ifaN"
        "vCcAAAAAi0cIixcPr8UB2IsUgonRD7bGK0QkJA+20sH5EA+2yStMJCCJzsH+HzHxKfGJxsH+HzHwKfA5wQ9MyCtUJCiJ1sH+HzHyKfI5"
        "0Q9N0TtUJCwPjgoBAACDwwE5XCQYdaGDRCQwAYtEJDA5RCRID4Vm////i0QkNIPEXFteX13DZpA5xg+NMAEAACtEJHwrdCR8x0QkNAAA"
        "AACJRCQoifJmkItcJDg56w+NmwAAAInQi3QkfIlUJCQPr8IB1olEJCDrDo20JgAAAACDwwE53XR0i0cIixcPr8YB2IsEgiX///8AOch1"
        "44nYK0QkeA+vwANEJCCJRCQY20QkGNnA2frZ7t/qD4fEAAAA3dnZfCROD7dEJE6AzAxmiUQkTNlsJEzbXCQY2WwkTotEJBg5hCSAAAAA"
        "D53Ag8MBD7bAAUQkNDnddYyLVCQkg8IBOVQkKA+FTP///4tEJDSDxFxbXl9dw4nYK0QkeA+vwANEJDyJRCRA20QkQNnA2frZ7t/qd2zd"
        "2dl8JE4Pt0QkToDMDGaJRCRM2WwkTNtcJEDZbCROi0QkQDmEJIAAAAAPncAPtsABRCQ06Z7+///HRCQ0AAAAAItEJDSDxFxbXl9dw91c"
        "JBjdHCSJTCR06AAAAADd2ItMJHTdRCQY6R/////dXCRA3Rwk6AAAAADd2N1EJEDrgpA="
    )
    static x64 :=
    (
        "QVdBVkFVQVRVV1ZTSIPsWA8pdCQwDyl8JECLhCTAAAAAwegfA4QkwAAAANH4RImEJLAAAACLtCSwAAAAQYnERIuUJLAAAABFAcxEiYwku"
        "AAAAEUxyQHGi6wkuAAAAESLhCTIAAAAQSnCRYnTRQ+26EUPSNkpxYtBEEEPSOlEjUj/OfCLQRRBD0bxRI1I/0Q54EUPRuFFhMAPhAIBA"
        "ABBidYPtsYPtvpBwe4QQYnHRQ+29kQ55Q+N7AEAAEQrpCS4AAAARTHSK6wkuAAAAESJZCQgZg/v/0SJVCQkDx9EAABBOfMPjYMAAABB"
        "iepEi6QkuAAAAESJ20QPr9VBAexmkItBEEEPr8SNFBhIiwGLFJCJ0MH4EA+2wEQp8EGJwEHB+B9EMcBEKcBBicAPtsYPttJEKfhBicFB"
        "wfkfRDHIRCnIQTnAQQ9NwCn6QYnQQcH4H0QxwkQpwjnQD0zCRDnoD44DAQAAg8MBOd51lIPFATlsJCAPhWf///9Ei1QkJA8odCQwDyh8"
        "JEBEidBIg8RYW15fXUFcQV1BXkFfww8fQABEOeUPjf4AAABEi7QksAAAAESLhCS4AAAARTHSZg/v/0SLvCTAAAAAK6wkuAAAAEQrpCS4"
        "AAAAZg8fhAAAAAAAQTnzfXNBie1BjTwoRInbRA+v7esKDx8Ag8MBOd50WYtBEA+vx0SNDBhIiwFCiwSIJf///wA50HXfidhmD+/ARCnw"
        "D6/ARAHo8g8qwGYPLvhmDyjw8g9R9nd18g8sxkE5xw+dwIPDAQ+2wEEBwjneda4PH4AAAAAAg8UBQTnsdYDpGf///w8fAInYK4QksAAA"
        "AGYP78APr8BEAdDyDyrAZg8u+GYPKPDyD1H2d27yDyzGOYQkwAAAAA+dwA+2wAFEJCTpvv7//0Ux0unP/v//RImEJLgAAACJlCSoAAAAS"
        "ImMJKAAAABEiVQkJESJXCQg6AAAAABEi1QkJESLXCQgRIuEJLgAAACLlCSoAAAASIuMJKAAAADpP////0iJjCSgAAAARIlUJCxEiVwkK"
        "OgAAAAARItUJCxEi1wkKEiLjCSgAAAA6WT///+QkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelCountRegion( xBits ) {
    static x86 :=
    (
        "VVdWU4PsKItEJEyLdCREi1wkVItUJEABxotMJFCIHCSJdCQUhcB5DItEJESJdCREiUQkFIt0JEgBzol0JBCFyXkMi0QkSIl0JEiJRCQQ"
        "i0wkRIXJD4jGAQAAi0QkSIXAD4i6AQAAi0QkPItMJBSLbCQQi3AIOc6NRv+JdCQYD0fBiUQkFInHi0QkPItADI1I/znoD0fNiUwkEITb"
        "D4TuAAAAOUwkSA+NagEAAInQD690JEjB6BAPtsCJRCQED7bGiUQkCItEJESJdCQcMfbB4AKJRCQkjQS9AAAAAIlEJCAPtsKJRCQMifaN"
        "vCcAAAAAi0QkFDlEJER9bItEJDyLXCQkiyiLRCQcweACAcMB6wNsJCABxY12AIsTD7bOK0wkCInQD7bSic/B+BDB/x8PtsArRCQEMfkp"
        "+YnHwf8fMfgp+DjID0fIK1QkDInXwf8fMfop+jjRD0PROBQkg97/g8MEOd11sotcJBiDRCRIAQFcJByLRCQQO0QkSA+Fb////4nwg8Qo"
        "W15fXcOQjXQmADlMJEgPjXwAAACLRCREi3wkSItsJEjB4AIPr/6JRCQEi0QkFMHgAokEJDHAjXQmAIt0JBQ5dCREfTeLdCQ8i0wkBIse"
        "jTS9AAAAAAHxAdkDHCQB3o10JgCLGYHj////ADnaD5TDg8EED7bbAdg58XXng8UBA3wkGDlsJBB1soPEKFteX13Dg8QoMcBbXl9dw7j9"
        "////6Vn///+QkJCQkJA="
    )
    static x64 :=
    (
        "QVdBVkFVQVRVV1ZTSIPsGIuEJJAAAABBicREiUQkcESLhCSAAAAARIt0JHBIiUwkYIuMJIgAAABFAcZFhcB5DUSLRCRwRIl0JHBFicZG"
        "jTwJhcl5CUSJyUWJ+UGJz4tMJHCFyQ+IggEAAEWFyQ+IeQEAAEiLdCRgi14QjUv/RDnziVwkCEQPRvGLThREjUH/RDn5RQ9G+ITAD4TZ"
        "AAAARTn5D409AQAAi3wkcIneidUPtsZBD6/xwe0QQYnFD7baRCn3QA+27THAiXwkDEQB9kQ5dCRwfXlIi3wkYItMJAxIiz9EjRQxZg8f"
        "hAAAAAAARInSiwyXD7bVRCnqQYnQQcH4H0QxwkQpwkGJ0InKD7bJwfoQD7bSKepBidNBwfsfRDHaRCnaRDjCQQ9G0CnZQYnIQcH4H0Qx"
        "wUQpwTjKD0LRQTjUg9j/QYPCAUQ51nWgQYPBAQN0JAhFOc8PhW////9Ig8QYW15fXUFcQV1BXkFfw2YPH0QAAEU5+X1oQYnaid6LXCRw"
        "SItsJGBFD6/Ri3wkcDHARCnzRQHyDx9EAABEOfd9L0yLXQBCjQwTDx8AQYnIR4sEg0GB4P///wBEOcJBD5TAg8EBRQ+2wEQBwEE5ynXc"
        "QYPBAUEB8kU5z3XA6Xz///8xwOl1////uP3////pa////5CQkJCQkJCQkJA="
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelArrayRegion( xBits ) {
    static x86 :=
    (
        "VbqQ0AMAV1ZTg+wkgXwkVJDQAwAPTlQkVItEJEiLXCRQi3QkOIt8JDyJVCQYi1QkQItsJESIXCQLi0wkTAHCiRQkhcB5C4tEJECJVCRAi"
        "QQkjRQpiVQkIIXJeQiJ6InViUQkIItEJECFwA+IoAEAAIXtD4iYAQAAiwwki0YIOciNUP+LRgwPR9GLTCQgiRQkOciNUP8PR9GJVCQghN"
        "sPhOwAAAA51Q+NYAEAAIn4x0QkHAAAAADB6BAPtsCJRCQMifgPtsSJRCQQifgPtsCJRCQUiwQkOUQkQA+NlQAAAIsGi1wkQIlEJATrDZC"
        "NdCYAg8MBORwkdHyLRgiLfCQED6/FAdiLFIeJ0Q+2xitEJBAPttLB+RAPtskrTCQMic/B/x8x+Sn5icfB/x8x+Cn4OMgPR8grVCQUidfB"
        "/x8x+in6ONEPQ9E4VCQLcqSJ2ItWBItMJBzB4BAB6IkEijlMJBgPhJkAAACDRCQcAYPDATkcJHWEg8UBOWwkIA+FUf///4tEJBzrfYn2"
        "jbwnAAAAADtsJCB9djHJiwQkOUQkQH1Oix6LRCRAiVwkBOsLjXYAg8ABOQQkdDeLVgiLXCQED6/VAcKLFJOB4v///wA5+nXficKLXgTB4"
        "hAB6okUizlMJBh0HIPBAYPAATkEJHXJg8UBOWwkIHWgicjrCI10JgCLRCQYg8QkW15fXcMxwOv0uP3////r7ZCQkJCQkJCQkA=="
    )
    static x64 :=
    (
        "QVdBVkFVQVRVV1ZTSIPsGL+Q0AMAi6wkmAAAAESLlCSAAAAAi4QkkAAAAIH9kNADAA9P70GJxkSJRCRwi1wkcESLhCSIAAAARAHTRYXSe"
        "QxEi1QkcIlcJHBEidNDjTQIiXQkDEWFwHkLRYnIQYnxRIlEJAxEi0QkcEWFwA+IrQEAAEWFyQ+IpAEAAESLQRCLdCQMRY1Q/0E52ESLQR"
        "RBD0baRY1Q/0E58EQPR9ZEiVQkDITAD4TmAAAARTnRD41oAQAAQYnUD7bGMf8PtvJBwewQQYnHRQ+25DlcJHAPjaUAAABMiylEi1QkcOs"
        "QDx8AQYPCAUQ50w+EiwAAAItBEEEPr8FEAdBBi1SFAInQwfgQD7bARCngQYnAQcH4H0QxwEQpwEGJwA+2xg+20kQp+EGJw0HB+x9EMdhE"
        "KdhEOMBBD0bAKfJBidBBwfgfRDHCRCnCONAPQsJBOMZyk0SJ0kyLQQiJ+MHiEEQBykGJFIA5/Q+EoAAAAEGDwgGDxwFEOdMPhXX///9Bg"
        "8EBRDlMJAwPhUL///+J+Ot/Dx9EAABEidZFOdEPjX8AAABEi1wkcDH/QTnbfU5MixFEidjrB4PAATnDdD9Ei0EQRQ+vwUEBwEeLBIJBge"
        "D///8AQTnQdd5BicRMi2kIQYn4QcHkEEUBzEeJZIUAOf10HIPAAYPHATnDdcFBg8EBRDnOdaSJ+OsHDx9EAACJ6EiDxBhbXl9dQVxBXU"
        "FeQV/DMcDr67j9////6+SQkJCQkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelPosition( xBits ) {
    static x86 :=
    (
        "VVdWU4tUJBSLdCQci0wkGItCCIt8JCCLXCQkOfAPho0AAAA5egwPhoQAAAAPr8eLEgHwvgEAAACLFIKJ0CX///8AOch0WTH2hNt0U4nPD"
        "7bricYPttLB7xDB/hAPtsSJ+w+2+yn+iffB/x8x/in+D7b5D7bNKfqJ18H/HzH6Kfo51g9N1inIicHB+R8xyCnIOcIPTcI5xQ+dwA+2w"
        "InGW4nwXl9dw412AI28JwAAAAC+/v///+vokJCQkJCQkJCQ"
    )
    static x64 :=
    (
        "i0EQRItUJChEOcAPhp8AAABEOUkUD4aVAAAARA+vyEiLAUUByEKLDIBBuAEAAACJyCX///8AOdB0aEUxwEWE0nRgRQ+2ykGJ0kGJwA+2y"
        "UHB6hBBwfgQD7bERQ+20kUp0EWJwkHB+h9FMdBFKdBED7bSD7bWRCnRQYnKQcH6H0Qx0UQp0UE5yEEPTcgp0Jkx0CnQOcEPTMhFMcBBO"
        "clBD53ARInAw2YuDx+EAAAAAABBuP7////r6pCQkJCQkJCQ"
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}

ScanPixelRegion( xBits ) {
    static x86 :=
    (
        "VVdWU4PsHIt8JDSLXCQ4i1QkQItEJDCLdCQ8i2wkRIl8JAiLfCRIjQwaiXwkDIt8JEyF0nkGidqJy4nRjVQ1AIXteQaJ9YnWieqF2w+I3g"
        "AAAIX2D4jWAAAAOUgID0ZICDlQDA9GUAyJ1YtQBIlyBIt0JAiJSggPtkwkDIkaiWoMiXIQiUoUhf90NYP/AXRQg/8CdFuD/wN0NoP/BHRx"
        "g/8FdHyD/wZ0V4P/Bw+FiwAAAIlEJDCLQCDrDJCNdCYAiUQkMItAEIPEHFteX13/4IlEJDCLQBzr7o20JgAAAACJRCQwi0AYg8QcW15fXf"
        "/giUQkMItAFIPEHFteX13/4IlEJDCLQCTrvo20JgAAAACJRCQwi0As666NtCYAAAAAiUQkMItAKOuejbQmAAAAALj9////g8QcW15fXcO4"
        "/////+vxkJCQkJCQkJCQkJCQ"
    )
    static x64 :=
    (
        "VlOLRCQ4RItcJECLXCRIi3QkUEaNFACFwHkJRInARYnQQYnCQ40EC0WF23kJRYnLQYnBRInYRYXAD4jhAAAARYXJD4jYAAAARDlREEQPRl"
        "EQD7bbOUEUD0ZBFEWJ00GJwkiLQQhEiQBEiUgERIlYCESJUAyJUBCJWBSF9nQyg/4BdE2D/gJ0WIP+A3Qzg/4EdG6D/gV0eYP+BnRUg/4H"
        "D4WDAAAASItBOFteSP/gZpBIi0EYW15I/+APH4AAAAAASItBMFteSP/gDx+AAAAAAEiLQShbXkj/4A8fgAAAAABIi0EgW15I/+APH4AAAA"
        "AAEiLQVBbXkj/4A8fgAAAAABIi0FIW15I/+APH4AAAAAAuP3///9bXsO4/////+v2kA=="
    )

    if ( xBits == 64 ) {
		return x64
	}
    
	return x86
}