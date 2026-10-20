always @(*) begin
    if (active) begin
        assert (wbs_ack_o   == buf_wbs_ack_o);
        assert (wbs_dat_o   == buf_wbs_dat_o);
        assert (la_data_out == buf_la_data_out);
        assert (io_out      == buf_io_out);
        assert (io_oeb      == buf_io_oeb);
    end

    if (!active) begin
        assert (wbs_ack_o   == 1'b0);
        assert (wbs_dat_o   == 32'b0);
        assert (la_data_out == 32'b0);
        assert (io_out      == `MPRJ_IO_PADS'b0);
        assert (io_oeb      == `MPRJ_IO_PADS'b0);
    end
end
