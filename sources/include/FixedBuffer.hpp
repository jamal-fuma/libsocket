#ifndef FUMA_LIBRARIES_SOCKET_FIXED_BUFFER_HPP
#define FUMA_LIBRARIES_SOCKET_FIXED_BUFFER_HPP

#include <stddef.h>
#include <vector>

class FixedBuffer
{
public:
    FixedBuffer(size_t size);
    ~FixedBuffer();

    FixedBuffer(const FixedBuffer & rhs);
    FixedBuffer & operator=(const FixedBuffer & rhs);
    void assign(const FixedBuffer & rhs);

    bool is_empty() const;
    bool is_write_possible() const;
    bool is_read_pending() const;

    char * write_head();
    char * read_head();
    size_t length() const;
    void complete_write(size_t amount);
    void complete_read(size_t amount);
    size_t capacity();
    void clear();

private:
    std::vector<char> m_buf;
    int m_avail;
    int m_written;
    size_t m_size;
};

#endif /* ndef FUMA_LIBRARIES_SOCKET_FIXED_BUFFER_HPP */
