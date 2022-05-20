// Copyright AudioKit. All Rights Reserved.

#pragma once

#include "Instrmnt.h"
#include "DSPBase.h"

/// Common base class for STK instruments.
class STKInstrumentDSP : public DSPBase {

public:

    STKInstrumentDSP();

    virtual stk::Instrmnt* getInstrument() = 0;

    void reset() override;

    void handleMIDIEvent(AUMIDIEvent const& midiEvent) override;

    void process(FrameRange range) override;

};
