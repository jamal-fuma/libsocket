#ifndef FUMA_LIBRARIES_CLIENT_BUFFERED_SOCKET_HPP
#define FUMA_LIBRARIES_CLIENT_BUFFERED_SOCKET_HPP

#include <string>

#include "FixedBuffer.hpp"
#include "StreamSocket.hpp"

class Address;
class EventLoopCTX;

class BufferedSocket
{
    public:
        enum {
            kBufferSize    = 1024,
            kInvalidSocket =-1
        };

        BufferedSocket();
        explicit BufferedSocket(int sock);
        ~BufferedSocket();

        BufferedSocket(const BufferedSocket & rhs);
        BufferedSocket & operator=(const BufferedSocket & rhs);

        void copy_assign(const BufferedSocket & rhs);
        void move_assign(BufferedSocket & rhs);
        void swap(BufferedSocket & rhs);

        int get_sockfd() const;
        bool is_valid() const;
        bool is_empty() const;
        int get_peername(Address & addr);
        bool is_ready_for_reader() const;
        bool is_ready_for_writer() const;
        void clear();
        void close();

        ssize_t recv();
        std::string read();
        std::string drain();
        ssize_t write(const std::string & str);

        ssize_t send(BufferedSocket & dest);

        ssize_t recv_oob();
        ssize_t send_oob(BufferedSocket & dest);
        int connect(const Address & addr);

        void add_if_readable(EventLoopCTX & ctx);
        void add_if_writable(EventLoopCTX & ctx, BufferedSocket & sock_out);
        void add_if_oob(EventLoopCTX & ctx);
        void add_if_pollable(EventLoopCTX & ctx, BufferedSocket & sock_out);

        void recv_if_readable(EventLoopCTX & ctx);
        void send_if_writable(EventLoopCTX & ctx, BufferedSocket & sock_out);
        void close_if_empty(BufferedSocket & sock_out);
        void xfer_if_oob(EventLoopCTX & ctx, BufferedSocket & sock_out);

    private:
        StreamSocket m_sock;
        FixedBuffer  m_buffer;
        char m_oob_ch;
};

#endif /*ndef FUMA_LIBRARIES_CLIENT_BUFFERED_SOCKET_HPP */
